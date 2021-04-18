import 'package:flutter/cupertino.dart';

class Beverages{
  final String id;
  final String name;
  final int price;
  final String description;
  final String image;
  final String catagoryId;
  const Beverages({
    @required this.id,
    @required this.name,
    this.image,
    this.price,
    @required this.catagoryId,
    this.description});
  factory Beverages.fromJson(Map<String, dynamic> json) =>
      Beverages(
          id: json['id'],
          name: json['name'],
          catagoryId: json['catagoryId'],
          price: json['price'],
          description: json['info'],
          image: json['image']
      );
  Map<String,dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'catagoryId': catagoryId,
        'info': description,
        'price': price,
        'image': image
      };

}