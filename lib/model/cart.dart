import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Cart extends Equatable {
  final String id;
  final String userid;
  final String name;
  final String price;
  final String description;
  final String image;
  final String size;
  final String totalcount;

  Cart(
      {this.id,
      @required this.userid,
      @required this.name,
      @required this.price,
      @required this.description,
      @required this.image,
      @required this.size,
      @required this.totalcount
      });
  @override
  List<Object> get props => [id, userid, name, price, description, image, size,totalcount];

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        id: json['_id'],
        userid: json['userid'],
        name: json['name'],
        price: json['price'],
        description: json['description'],
        image: json['image'],
        size: json['size'],
        totalcount: json['totalcount']
        
        );
  }
  @override
  String toString() =>
      'Product {id:$id,userid :$userid, name : $name,price:$price,description:$description,image:$image,size:$size,totalcount:$totalcount}';
}
