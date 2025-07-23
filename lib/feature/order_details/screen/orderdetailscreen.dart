import 'package:amazone_clonee/feature/search/screen/searchscreen.dart';
import 'package:amazone_clonee/model/order.dart';
import 'package:flutter/material.dart';

class Orderdetailscreen extends StatefulWidget {
  static const String routename = '/order-detals';
  final Order order;
  const Orderdetailscreen({super.key, required this.order});

  @override
  State<Orderdetailscreen> createState() => _OrderdetailscreenState();
}

class _OrderdetailscreenState extends State<Orderdetailscreen> {
  void navigatetosearchscreen(String query) {
    Navigator.pushNamed(context, Searchscreen.routename, arguments: query);
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
                      // This method  takes argument query from onFieldSubmitted  function that passes a String of that Textformfield
                      // also can be used as this if new to this ;
                      // (String query) {
                      //   print(query);
                      // },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap:
                              () {}, // nothing happening on clicking the icon
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.search),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(top: 08),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        hintText: "Search Products",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "View Order details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
