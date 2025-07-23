import 'package:flutter/material.dart';

class Showappbar extends StatefulWidget {
  const Showappbar({super.key});

  @override
  State<Showappbar> createState() => _ShowappbarState();
}

class _ShowappbarState extends State<Showappbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            Image.asset(
              'assets/images/amazon_in.png',
              width: 170,
              height: 50,
              color: Colors.orangeAccent,
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications),
              color: Colors.black87,
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
              color: Colors.black87,
              iconSize: 30,
            ),
          ],
        ),
      ],
    );
  }
}
