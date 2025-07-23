// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazone_clonee/model/ratingmodel.dart';

class Productmodel {
  final String name;
  final String description;
  final double quantity;
  final String category;
  final List<String> images;
  final double price;
  final String? id;
  final List<Ratingmodel>? rating;
  Productmodel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.images,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'ratings': rating?.map((x) => x.toMap()).toList(),
    };
  }

  factory Productmodel.fromMap(Map<String, dynamic> map) {
    return Productmodel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      images: List<String>.from((map['images'] ?? [])),
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id']?.toString(),
      rating: map['ratings'] != null
          ? List<Ratingmodel>.from(
              map['ratings']?.map((x) => Ratingmodel.fromMap(x)),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Productmodel.fromJson(String source) =>
      Productmodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
