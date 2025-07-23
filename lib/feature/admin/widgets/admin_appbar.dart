import 'package:flutter/material.dart';

class AdminAppbar extends StatefulWidget {
  const AdminAppbar({super.key});

  @override
  State<AdminAppbar> createState() => _AdminAppbarState();
}

class _AdminAppbarState extends State<AdminAppbar> {
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
            Text(
              "Admin",
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
    
  }
}
