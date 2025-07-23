import 'package:amazone_clonee/common/widgets/loader.dart';
import 'package:amazone_clonee/feature/home/services/home_services.dart';
import 'package:amazone_clonee/feature/product_detail/screen/productdetailscreen.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

class Cateogrydealscreen extends StatefulWidget {
  final String Cateogry;
  static const String routename = '/cateogry-deals';
  const Cateogrydealscreen({super.key, required this.Cateogry});

  @override
  State<Cateogrydealscreen> createState() => _CateogrydealscreenState();
}

class _CateogrydealscreenState extends State<Cateogrydealscreen> {
  List productlist = [];
  HomeServices homeservice = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCateogryProducts();
  }

  Future<void> fetchCateogryProducts() async {
    productlist = await homeservice.fetchCateogryProducts(
      context: context,
      cateogry: widget.Cateogry,
    );
    // print(productlist[0].toString());
    setState(() {});
  }

  void navigatetoProductdetailScreen(Productmodel product) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: Text(
            widget.Cateogry,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: productlist==null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Keep shopping for ${widget.Cateogry}",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: productlist.length,

                    itemBuilder: (context, index) {
                      final product = productlist[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Productdetailscreen.routename,
                            arguments: product,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(product.images[0]),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 0,
                                top: 5,
                                right: 15,
                              ),
                              child: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
