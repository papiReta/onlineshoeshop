import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shoe_node_api/model/product.dart';

class ProductDataProvider {
  static String ip = '192.168.42.165';
  final _baseUrl = 'http://192.168.42.165:3000';

  final Client httpClient;
  ProductDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Product> createProduct(Product product) async {
    try {
      final Response response =
          await httpClient.post(Uri.http('$ip:3000', '/products'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(<String, dynamic>{
                'name': product.name, 
                'price': product.price,
                'description': product.description,
                'image': product.image,
                'size': product.size
              }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      print(e.message);
    }
  }
  

  Future<List<Product>> getProducts() async {
    print('get product intializing ....');
    // print(printIps().toString());
    Response response;
    try {
      response = await httpClient.get('$_baseUrl/products');
      print(response.statusCode);
    } catch (e) {
      print(e.toString());
    }

    if (response.statusCode == 200) {
      final products = jsonDecode(response.body) as List;
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to Load Products');
    }
  }

  Future<void> deleteProduct(String id) async {
    print(id);
    print(
        "Deltting Product........................................................... ");
    try {
      final Response response = await httpClient.delete(
          '$_baseUrl/products/$id',
          headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      if (response.statusCode != 204) {
        throw Exception('Failed To Delete Product');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final Response response = await httpClient.put(
        '$_baseUrl/products/${product.id}',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(<String, dynamic>{
          'id': product.id,
          'name': product.name,
          'price': product.price,
          'description': product.description,
          'image': product.image,
          'size': product.size,
        }),
      );
      print(response.statusCode);
      if (response.statusCode != 204) {
        throw Exception('Failed To Update Product');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
