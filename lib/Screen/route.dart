import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_node_api/Screen/User/customPage.dart';
import 'package:shoe_node_api/Screen/User/pages/cart.dart';
import 'package:shoe_node_api/Screen/User/pages/productDetail.dart';
import 'package:shoe_node_api/Screen/UserRouteArgument.dart';
import 'package:shoe_node_api/Screen/adminpage.dart';
import 'package:shoe_node_api/Screen/auth/login_screen.dart';
import 'package:shoe_node_api/Screen/auth/register.dart';
import 'package:shoe_node_api/model/product.dart';

class MyRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
    if (settings.name == LoginScreen.routeName) {
      return MaterialPageRoute(builder: (context) => LoginScreen());
    }
        if (settings.name == "/cart") {
      return MaterialPageRoute(builder: (context) => Cart());
    }
    if (settings.name == productDetail.routeName) {
      Product product = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => productDetail(product: product));
    }
    if (settings.name == CustomPage.routeName) {
      final UserRouteArgumnet args = settings.arguments;
      return MaterialPageRoute(builder: (context) {
        return CustomPage(
            // user:args.user
            );
      });
    }
    if (settings.name == AdminPage.routeName) {
      return MaterialPageRoute(builder: (context) => AdminPage());
    }
    if (settings.name == RegisterScreen.routeName)
      return MaterialPageRoute(builder: (context) => RegisterScreen());
  }
}
class ProductArgument {
  final Product product;
  final bool update;
  ProductArgument({this.product, this.update});
}
