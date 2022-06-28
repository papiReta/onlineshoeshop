import 'package:flutter/material.dart';
import 'package:shoe_node_api/data_provider/product_provider.dart';
import 'package:shoe_node_api/model/product.dart';
class ProductRepo {
  final ProductDataProvider productDataProvider;

  ProductRepo({@required this.productDataProvider})
      : assert(productDataProvider != null);

  Future<Product> createProduct(Product product) async {
    return await productDataProvider.createProduct(product);
  }

  Future<List<Product>> getProducts() async {
    return await productDataProvider.getProducts();
  }

  Future<void> updateProduct(Product product) async {
    return await productDataProvider.updateProduct(product);
  }

  Future<void> deleteProduct(String id) async {
    return await productDataProvider.deleteProduct(id);
  }
}
