import 'package:amazone_clonee/feature/admin/widgets/posts.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:flutter/material.dart';

class Adminbottombar extends StatefulWidget {
  const Adminbottombar({super.key});

  @override
  State<Adminbottombar> createState() => _AdminbottombarState();
}

class _AdminbottombarState extends State<Adminbottombar> {

    double bottombarwidth = 2;
      int _page = 0;

// function to update pages in current time with changing screen
 void updatepage(int page) {
      setState(() {
        _page = page;
      });
    }

    // list of pages value t refer to difreent screens 
  List<Widget> pages = [
   const PostsScreen(),
    const Center(child: Text("Analytic page")),

    const Center(child: Text("cart  page")),
  ];
  
  @override
  Widget build(BuildContext context) {
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
              ), 
            ),
            label: '',
          ),

          // analytic icons bottom bar
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
              child: const Icon(Icons.analytics, color: Colors.black),
            ),
            label: '',
          ),

          // inbox  icons bottom bar
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
              child: const Icon(Icons.all_inbox_outlined, color: Colors.black),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
