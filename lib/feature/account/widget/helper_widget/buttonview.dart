import 'dart:ui';

import 'package:amazone_clonee/globals.dart/globls.dart';
import 'package:flutter/material.dart';

class Buttonview extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const Buttonview({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white24,
        ),
        height: 40,

        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withValues(
              colorSpace: ColorSpace.extendedSRGB,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () {
            onTap();
          },
          child: Text(
            text,
            style: TextStyle(
              color: Globls.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
