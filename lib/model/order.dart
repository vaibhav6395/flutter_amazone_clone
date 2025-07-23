// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazone_clonee/model/productmodel.dart';

class Order {
  final String id;
  final List<Productmodel> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int Orderat;
  final int status;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.Orderat,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'Orderat': Orderat,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      products: List<Productmodel>.from(
        map['products']?.map((x) => Productmodel.fromMap(x['product'])),
      ).toList(),
      quantity: List<int>.from(
        map['products']?.map((x) => x['quantity']),
      ).toList(),
      address: map['address'] as String,
      userId: map['userId'] as String,
      Orderat: map['Orderat'] as int,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
