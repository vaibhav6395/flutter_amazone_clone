import 'package:amazone_clonee/feature/home/screen/cateogrydealscreen.dart';
import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:flutter/material.dart';

class AppCateogry extends StatelessWidget {
  const AppCateogry({super.key});
  
void navigatetocateogrypage(BuildContext context,String cateogry){
  Navigator.pushNamed(context,Cateogrydealscreen.routename,arguments: cateogry);
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Globls.categoryImages.length,
        itemExtent: size.width / 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap:()=> navigatetocateogrypage(context,Globls.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(50),
                    child: Image.asset(
                      Globls.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  Globls.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
