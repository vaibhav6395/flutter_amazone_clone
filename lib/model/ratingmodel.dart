// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Ratingmodel {
  final String userId;
  final double rating;

  Ratingmodel({required this.userId, required this.rating});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory Ratingmodel.fromMap(Map<String, dynamic> map) {
    return Ratingmodel(
      userId: map['userId'] ,
      rating: (map['rating'] as num).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Ratingmodel.fromJson(String source) => Ratingmodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
