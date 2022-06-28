import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String price;
  final String description;
  final String image;
  final String size;

  Product(
      {this.id,
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.image,
      @required this.size});
  @override
  List<Object> get props => [id, name, price,description, image, size];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['_id'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        image: json['image'],
        size: json['size']);
  }
  @override
  String toString() =>
      'Product {id:$id, name : $name,price:$price,description:$description,image:$image,size:$size}';
}
