import 'package:amazone_clonee/common/widgets/stars.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';

class Searchwidget extends StatelessWidget {
  final Productmodel productmodel;
  const Searchwidget({super.key, required this.productmodel});

  @override
  Widget build(BuildContext context) {
     double totalRating = 0;
     double avgrating=0;
    for (int i = 0; i < productmodel.rating!.length;i++) {
      avgrating += productmodel.rating![i].rating;

       if (totalRating != 0) {
        avgrating = totalRating / productmodel.rating!.length;
      }}
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                productmodel.images[0],
                fit: BoxFit.fitWidth,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      productmodel.description,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:  Stars(rating:avgrating)
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '\$${productmodel.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Eligible for Free Shipping',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(color: Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
