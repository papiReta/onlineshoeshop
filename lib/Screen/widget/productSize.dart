import 'package:flutter/material.dart';
import 'package:shoe_node_api/Screen/utils/constants.dart';

class ProductSize extends StatefulWidget {
  final List productSize;

  const ProductSize({Key key, this.productSize}) : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Constant.kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  widget.productSize[i].toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
        ],
      ),
    );
  }
}
