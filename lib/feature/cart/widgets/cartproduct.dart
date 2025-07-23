import 'package:amazone_clonee/controller/provider_controller/user_provider.dart';
import 'package:amazone_clonee/feature/cart/services/cart_services.dart';
import 'package:amazone_clonee/feature/product_detail/servics/productdetail_service.dart';
import 'package:amazone_clonee/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartproduct extends StatefulWidget {
  final int index;
  const Cartproduct({super.key, required this.index});

  @override
  State<Cartproduct> createState() => _CartproductState();
}

class _CartproductState extends State<Cartproduct> {
  @override
  Widget build(BuildContext context) {
    final productmodel = context.watch<User_Provider>().user.cart[widget.index];
    final product = Productmodel.fromMap(productmodel['product']);
    final ProductdetailService productdetailService = ProductdetailService();
    final CartServices cartServices=CartServices();

    void increaseQuantity(Productmodel products) {
      productdetailService.addToCart(context: context, Product: products);
    }

void decreaseQuantity(Productmodel product){
  cartServices.removefromcart(context: context, Product: product);
}
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Image.network(
                  productmodel['product']['images'][0],
                  fit: BoxFit.fitWidth,
                  height: 135,
                  width: 135,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          productmodel['product']['description'],
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '\$${productmodel['product']['price']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'In Stock',
                          style: TextStyle(color: Colors.teal),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1.8),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: ()=>decreaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(Icons.remove),
                        ),
                      ),

                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.4),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(productmodel['quantity'].toString()),
                        ),
                      ),

                      GestureDetector(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
