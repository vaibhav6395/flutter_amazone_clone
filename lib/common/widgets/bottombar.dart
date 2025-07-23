import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/account/screen/accountscreen.dart';
import 'package:amazone_clonee/feature/cart/screens/cartscreen.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:amazone_clonee/feature/home/screen/homescreen.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Bottombar extends StatefulWidget {
  static const String routename = '/main-home';
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  @override
  void initState() {
    super.initState();
setState(() {
  
});  }

  int _page = 0;

  List<Widget> pages = [
    const Homescreen(),
    const Cartscreen(),
    const Accountscreen(),
  ];
  void updatepage(int page) {
    setState(() {
      _page = page;
    });
  }

  double bottombarwidth = 2;
  @override
  Widget build(BuildContext context) {
    final userCartLenght = context.watch<User_Provider>().user.cart.length;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Globls.selectednavcolor,
        onTap: updatepage,
        unselectedItemColor: Globls.backgroundcolor,
        iconSize: 35,
        items: [
          // home icons bottom bar
          BottomNavigationBarItem(
            icon: Container(
              width: size.width / 8,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? Globls.selectednavcolor
                        : Globls.backgroundcolor,
                    width: bottombarwidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
                color: Colors.black,
              ), // home icons bottom bar
            ),
            label: '',
          ),

          // cart icons bottom bar
          BottomNavigationBarItem(
            icon: Container(
              width: size.width / 8,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? Globls.selectednavcolor
                        : Globls.backgroundcolor,
                    width: bottombarwidth,
                  ),
                ),
              ),
              child: badges.Badge(
                badgeContent: Text(userCartLenght.toString()),
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.white),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              ),
            ),
            label: '',
          ),

          // account  icons bottom bar
          BottomNavigationBarItem(
            icon: Container(
              width: size.width / 8,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? Globls.selectednavcolor
                        : Globls.backgroundcolor,
                    width: bottombarwidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_2_outlined, color: Colors.black),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
