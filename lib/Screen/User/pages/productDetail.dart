import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/Screen/User/pages/Home.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';
import 'package:shoe_node_api/Screen/widget/imageSwipe.dart';
import 'package:shoe_node_api/Screen/widget/productSize.dart';
import 'package:shoe_node_api/bloc/product_bloc.dart';
import 'package:shoe_node_api/bloc/product_event.dart';
import 'package:shoe_node_api/model/product.dart';

class productDetail extends StatelessWidget {
  final Product product;
  static const routeName = 'productDetail';
  productDetail({Key key, this.product});
  List imageList;
  List productSize;

  @override
  Widget build(BuildContext context) {
    productSize = [product.size];
    imageList = ['assets/nikeshoes1.jpg', 'assets/nikeshoes2.jpeg'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.kPrimaryColor,
        title: Text(this.product.name)),
      body: product != null
          ? ListView(
              padding: EdgeInsets.only(top: 30.0),
              children: [
                imageSwipe(imageList: imageList),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                        product.name,
                        style: Constant.boldHeading,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Navigator.of(context).pushNamed(
                                  //     AddProduct.routeName,
                                  //     arguments: ProductArgument(
                                  //         product: this.product, update: true));
                                }),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  context.read<ProductBloc>()
                                      .add(DeleteProduct(this.product));
                                  Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                                })
                          ],
                        ),
                      )
                    ])),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Text("Birr ${product.price}",
                      style: TextStyle(
                        
                          fontSize: 18.0,
                          color: Constant.kPrimaryColor,
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16.0,
                          color: Constant.kPrimaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                  child: Text(
                    "Select Size",
                    style: Constant.regularDarkText,
                  ),
                ),
                ProductSize(productSize: productSize),
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                            height: 65.0,
                            margin: EdgeInsets.only(
                              left: 16.0,
                            ),
                            decoration: BoxDecoration(
                            color: Constant.kPrimaryColor,
                                borderRadius: BorderRadius.circular(12.0)),
                            alignment: Alignment.center,
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            )),
                      )
                    ],
                  ),
                )
              ],
            )
          : Scaffold(
              body: Center(
                child: Text("Can't Load ${product.name} Detail"),
              ),
            )

      // return Scaffold(
      //     body: Center(
      //   child: CircularProgressIndicator(),
      // ));

    );
  }
}
