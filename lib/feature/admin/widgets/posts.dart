import 'package:amazone_clonee/common/widgets/loader.dart';
import 'package:amazone_clonee/feature/account/widget/helper_widget/productview.dart';
import 'package:amazone_clonee/feature/admin/screen/addproductscreen.dart';
import 'package:amazone_clonee/feature/admin/services/admin_services.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices adminServices = AdminServices();
  List<Productmodel>? products = [];

  //function to navigate on product screen on sucess 
  void navigatetoAddproduct() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(Addproductscreen.routename);
  }

// function to fetch products from server and save it to a list  uses in itembuilder
  Future<void> fetchallproducts() async {
    products = await adminServices.fetchallproduct(context);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchallproducts();
  }

//function to delete products  id fetched from productmodel class  at a given index  and  remove from list 
  void deleteproduct(Productmodel productmodel, int index) {
    adminServices.deleteproduct(
      context: context,
      product: productmodel,
      onsucess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: products!.length,
              itemBuilder: (context, index) {
                final productdata = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: Productview(Imageurl: productdata.images[0]),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productdata.name,
                            

                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteproduct(productdata, index),  // here productdata is list of   values of product fetched from server
                          // productlist behaves like a  modelclass  as it has already saved all values fetched at specific index
                          icon: Icon(Icons.delete_outlined),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigatetoAddproduct,
              tooltip: 'Add a product',
              shape: const CircleBorder(),
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
