import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/model/cart.dart';
import 'package:shoe_node_api/model/product.dart';

class CartDataProvider{
  static String ip = '192.168.42.46';
  final _baseUrl = 'http://192.168.42.46:3000';

  final Client httpClient;
  CartDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Cart> createCart(Cart cart) async {
    try {
      final Response response =
          await httpClient.post(Uri.http('$ip:3000', '/cart'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(<String, dynamic>{
                'userid':cart.userid,
                'name': cart.name, 
                'price': cart.price,
                'description': cart.description,
                'image': cart.image,
                'size': cart.size,
                'totalcount':cart.totalcount
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Cart.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create Cart');
      }
    } catch (e) {
      print(e.message);
    }
  }
  

  Future<List<Cart>> getCart() async {
    print('get Cart intializing ....');
    // print(printIps().toString());
    Response response;
    try {
      response = await httpClient.get('$_baseUrl/cart');
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }

    if (response.statusCode == 200) {
      final cart = jsonDecode(response.body) as List;
      return cart.map((e) => Cart.fromJson(e)).toList();
    } else {
      throw Exception('Failed to Load Cart');
    }
  }

  Future<void> deleteCart(String id) async {
    print(id);
    print(
        "Deltting Cart........................................................... ");
    try {
      final Response response = await httpClient.delete(
          '$_baseUrl/cart/$id',
          headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      if (response.statusCode != 204) {
        throw Exception('Failed To Delete Cart');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateCart(Cart cart) async {
    try {
      final Response response = await httpClient.put(
        '$_baseUrl/cart/${cart.id}',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(<String, dynamic>{
          'id': cart.id,
          'userid':cart.userid,
          'name': cart.name,
          'price': cart.price,
          'description': cart.description,
          'image': cart.image,
          'size': cart.size,
          'totalcount':cart.totalcount
        }),
      );
      print(response.statusCode);
      if (response.statusCode != 204) {
        throw Exception('Failed To Update Cart');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}