import 'package:amazone_clonee/common/widgets/loader.dart';
import 'package:amazone_clonee/feature/account/services/account_services.dart';
import 'package:amazone_clonee/feature/account/widget/helper_widget/productview.dart';
import 'package:amazone_clonee/feature/order_details/screen/orderdetailscreen.dart';
import 'package:flutter/material.dart';

import '../../../../model/order.dart';

class Showorder extends StatefulWidget {
  const Showorder({super.key});

  @override
  State<Showorder> createState() => _ShoworderState();
}

class _ShoworderState extends State<Showorder> {
  List<Order>? orders;
  AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  Future<void> fetchOrder() async {
   orders=await accountServices.fetchmyOrders(context: context);
    setState(() {});
    print(orders.toString());
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Orders",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),

                  InkWell(
                    onTap: () {},
                    child: Text(
                      "see all",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              Container(
                height: 150,
                padding: EdgeInsets.all(10.0),
                // color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Orderdetailscreen.routename,
                        );
                      },
                      child: Productview(
                        Imageurl: orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
