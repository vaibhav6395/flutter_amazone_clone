import 'package:amazone_clonee/feature/account/widget/helper_widget/buttonview.dart';
import 'package:flutter/material.dart';

class Showbutton extends StatefulWidget {
  const Showbutton({super.key});

  @override
  State<Showbutton> createState() => _ShowbuttonState();
}

class _ShowbuttonState extends State<Showbutton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Buttonview(text: "Your Order", onTap: () {}),
            Buttonview(text: "Your Order", onTap: () {}),
          ],),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Buttonview(text: "Your Order", onTap: () {}),
              Buttonview(text: "Your Order", onTap: () {}),
            ],
          ),
        
      ],
    );
  }
}
