import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;

class Crauselimage extends StatelessWidget {
  const Crauselimage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: Globls.carouselImages.map((i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.cover,
              height: 200,
              width: size.width,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }
}
