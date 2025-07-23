import 'package:amazone_clonee/feature/admin/widgets/admin_appbar.dart';
import 'package:amazone_clonee/feature/admin/widgets/admin_bottom_bar.dart';
import 'package:flutter/material.dart';

class Adminscreen extends StatefulWidget {
  const Adminscreen({super.key});

  @override
  State<Adminscreen> createState() => _AdminscreenState();
}

class _AdminscreenState extends State<Adminscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(color: Colors.blue),
          ),
          title: AdminAppbar(),
        ),
      ),
      body: Adminbottombar(),
    );
  }
}
