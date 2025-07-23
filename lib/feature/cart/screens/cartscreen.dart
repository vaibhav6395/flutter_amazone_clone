import 'dart:ui';

import 'package:amazone_clonee/common/widgets/showadressbar.dart';
import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/adresses/screen/adressscreen.dart';
import 'package:amazone_clonee/feature/cart/widgets/cartproduct.dart';
import 'package:amazone_clonee/feature/cart/widgets/cartsubtotal.dart';
import 'package:amazone_clonee/feature/search/screen/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({super.key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    void navigatetosearchscreen(String query) {
      Navigator.pushNamed(context, Searchscreen.routename, arguments: query);
    }
void navigateToaddress(int sum) {
      Navigator.pushNamed(context, Adressscreen.routename,arguments:sum.toString());
    }
    Size size = MediaQuery.of(context).size;
    final user = context.watch<User_Provider>().user;
      int sum = 0;
    for (var e in user.cart) {
      sum += (e['quantity'] as int) * (e['product']['price'] as int);
    }

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
            const Showadressbar(),
            const Cartsubtotal(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width / 2 - 90,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 251, 255, 14),
                ),
                child: GestureDetector(
                  onTap:()=> navigateToaddress(sum),
                  child: Text(
                    "Proceed To Buy(${user.cart.length} items )",
                    style: GoogleFonts.firaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              height: 2,
              color: Colors.black12.withValues(colorSpace: ColorSpace.sRGB),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: size.height * 0.5,
              child: ListView.builder(
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return Cartproduct(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
