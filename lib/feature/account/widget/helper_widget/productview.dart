import 'package:flutter/material.dart';

class Productview extends StatelessWidget {
  final String Imageurl;

  const Productview({super.key, required this.Imageurl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.2),

          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Container(
          width: 170,
          height: 180,
          padding: EdgeInsets.all(15.0),
          child: Image.network(Imageurl, fit: BoxFit.fitHeight, width: 100),
        ),
      ),
    );
  }
}
