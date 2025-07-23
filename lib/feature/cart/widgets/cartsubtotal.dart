import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartsubtotal extends StatelessWidget {
  const Cartsubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User_Provider>().user;
    int sum = 0;
    for (var e in user.cart) {
      sum += (e['quantity'] as int) * (e['product']['price'] as int);
    }
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text("Subtotal: ", style: const TextStyle(fontSize: 22)),
          Text(
            "\$${sum.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
