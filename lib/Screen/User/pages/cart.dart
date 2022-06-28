import 'package:flutter/material.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.kPrimaryColor,
        title: Row(children: [Icon(Icons.shopping_cart),Text("Cart")]),
      ),
    );
  }
}