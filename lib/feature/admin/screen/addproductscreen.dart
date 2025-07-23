import 'dart:io';
import 'package:amazone_clonee/feature/admin/services/admin_services.dart';
import 'package:amazone_clonee/utils/errorhandler.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addproductscreen extends StatefulWidget {
  static const String routename = '/add-product';
  const Addproductscreen({super.key});

  @override
  State<Addproductscreen> createState() => _AddproductscreenState();
}

class _AddproductscreenState extends State<Addproductscreen> {
  TextEditingController productcontroller = TextEditingController();
  TextEditingController Descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantityconntroller = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String Cateogry = "Mobiles";

  final _addproductformkey = GlobalKey<FormState>();
  // method to dispose all controller after use
  @override
  void dispose() {
    super.dispose();
    productcontroller.dispose();
    Descriptioncontroller.dispose();
    pricecontroller.dispose();
    quantityconntroller.dispose();
  }

// method to  post details to server of uploaded products
  void sellproduct() {
    if (_addproductformkey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellproducts(
        context: context,
        name: productcontroller.text,
        description: Descriptioncontroller.text,
        price: double.tryParse(pricecontroller.text) ?? 0.0,
        quantity: double.tryParse(quantityconntroller.text) ?? 0.0,
        cateogry: Cateogry,
        Images: images,
      );
    }
  }

  List<String> productcateogry = [
    'Mobiles',
    'Appliances',
    'Books',
    'Fashion',
    'Electronic',
    'Grocery',
  ];

  List<File> images = [];

// method to obtain images from device with help of pickimages
  void selectimages() async {
    var resimages = await pickimages();
    setState(() {
      images = resimages;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: const Text(
            "Add Products ",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addproductformkey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 15),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                                width: size.width,
                              ),
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectimages,
                        child: DottedBorder(
                          options: RoundedRectDottedBorderOptions(
                            dashPattern: [10, 5],
                            strokeWidth: 2,
                            padding: EdgeInsets.all(16),
                            radius: const Radius.circular(10),
                          ),
                          child: Container(
                            width: size.width,
                            height: size.height / 5.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  "Select Product images",
                                  style: TextStyle(color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                const SizedBox(height: 30),
                TextFormField(
                  maxLines: 7,
                  keyboardType: TextInputType.name,
                  controller: Descriptioncontroller,
                  decoration: InputDecoration(
                    hintText: "Description",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: pricecontroller,
                  decoration: InputDecoration(
                    hintText: "Price",

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: quantityconntroller,
                  decoration: InputDecoration(
                    hintText: "Quantity",

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                /// Drop-down menu
                SizedBox(
                  width: size.width,
                  child: DropdownButton(
                    items: productcateogry.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newval) {
                      setState(() {
                        Cateogry = newval!;
                      });
                    },
                    value: Cateogry,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                SizedBox(height: 10),

                InkWell(
                  onTap: sellproduct,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width / 2 - 50,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(color: Colors.orangeAccent),
                    child: Text(
                      "Upload products",
                      style: GoogleFonts.firaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
