import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Showadressbar extends StatefulWidget {
  const Showadressbar({super.key});

  @override
  State<Showadressbar> createState() => _ShowadressbarState();
}

class _ShowadressbarState extends State<Showadressbar> {
  @override
  Widget build(BuildContext context) {
        final user = Provider.of<User_Provider>(context, listen: true).user;


    return             Container(
              height: 40,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 144, 226, 221),
                    Color.fromARGB(255, 162, 236, 233),
                  ],
                  stops: [0.5, 1.0],
                ),
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Deliver to ${user.name} at ${user.address}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            );
  }
}
