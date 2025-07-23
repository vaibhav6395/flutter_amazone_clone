import 'package:amazone_clonee/common/widgets/loader.dart';
import 'package:amazone_clonee/common/widgets/showadressbar.dart';
import 'package:amazone_clonee/feature/product_detail/screen/productdetailscreen.dart';
import 'package:amazone_clonee/feature/search/services/search_services.dart';
import 'package:amazone_clonee/feature/search/widget/searchwidget.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

class Searchscreen extends StatefulWidget {
  static const String routename = '/search-screen';
  final String Searchquery;
  const Searchscreen({super.key, required this.Searchquery});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<Productmodel>? products;
  SearchServices serachservices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  Future<void> fetchSearchProduct() async {
    products = await serachservices.fetchedSearchProducts(
      context: context,
      searchquery: widget.Searchquery,
    );
    print('query${widget.Searchquery}');
    print('products${products![0].description}');

    setState(() {});
  }

  void navigatetosearchscreen(String query) {
    // for search again from searchscreen functionality as used in homescreen
    Navigator.pushNamed(context, Searchscreen.routename, arguments: query);
    query = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: EdgeInsets.only(left: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigatetosearchscreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(top: 08),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        hintText: widget.Searchquery,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  color: Colors.transparent,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.mic, color: Colors.black, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const Showadressbar(),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Productdetailscreen.routename,
                            arguments: products![index],
                          );
                        },
                        child: Searchwidget(productmodel: products![index]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
