import 'package:amazone_clonee/feature/home/widget/show_ui/app_cateogry.dart';
import 'package:amazone_clonee/feature/home/widget/show_ui/crauselimage.dart';
import 'package:amazone_clonee/feature/home/widget/show_ui/dealofday.dart';
import 'package:amazone_clonee/common/widgets/showadressbar.dart';
import 'package:amazone_clonee/feature/search/screen/searchscreen.dart';
import 'package:flutter/material.dart' hide CarouselController;

class Homescreen extends StatefulWidget {
  static const String routename = '/homescreen';
  static const List<String> slidingimages =[

  ];

  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
                        hintText:"Search Products",
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
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Showadressbar(),
            SizedBox(height: 10),
            AppCateogry(),
            SizedBox(height: 10),
            Crauselimage(),
            Dealofday(),
          ],
        ),
      ),
    );
  }
}
