import 'package:amazone_clonee/feature/account/widget/show_ui/showbutton.dart';
import 'package:amazone_clonee/feature/account/widget/show_ui/showappbar.dart';
import 'package:amazone_clonee/feature/account/widget/show_ui/showorder.dart';
import 'package:flutter/material.dart';

class Accountscreen extends StatelessWidget {
  const Accountscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: Showappbar(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top page view buttons
            Showbutton(),

            SizedBox(height: 15),
            Showorder(),
            
          ],
        ),
      ),
    );
  }
}
