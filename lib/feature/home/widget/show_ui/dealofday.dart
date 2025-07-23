import 'package:amazone_clonee/common/widgets/loader.dart';
import 'package:amazone_clonee/feature/home/services/home_services.dart';
import 'package:amazone_clonee/feature/product_detail/screen/productdetailscreen.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

class Dealofday extends StatefulWidget {
  const Dealofday({super.key});

  @override
  State<Dealofday> createState() => _DealofdayState();
}

class _DealofdayState extends State<Dealofday> {
  Productmodel? product;
  final HomeServices homeservices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchDealofDay();
  }

  Future<void> fetchDealofDay() async {
    product = await homeservices.fetchDealofDay(context: context);
    setState(() {});
  }

  void navigatetodetailscreen() {
    Navigator.pushNamed(context, Productdetailscreen.routename,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.description.isEmpty
        ? Center(child: const SizedBox())
        : GestureDetector(
          onTap: navigatetodetailscreen,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: const Text(
                    "Deal of the Day",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Image.network(
                  product!.images[0],
                  height: 250,
                  fit: BoxFit.fitHeight,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 25, top: 5, right: 40),
                  child: Text(
                    "\$100",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: const Text(
                    "Product information ",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: product!.images
                        .map(
                          (e) => Image.network(
                            e,
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ).copyWith(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "see all deals",
                    style: TextStyle(color: Colors.cyan[800]),
                  ),
                ),
              ],
            ),
          );
  }
}
