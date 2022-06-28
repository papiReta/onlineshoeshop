import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/Screen/User/pages/Home.dart';
import 'package:shoe_node_api/Screen/route.dart';
import 'package:shoe_node_api/bloc/product_bloc.dart';
import 'package:shoe_node_api/bloc/product_event.dart';
import 'package:shoe_node_api/model/product.dart';


class AddProduct extends StatefulWidget {
  static const routeName = 'productAddUpdate';
  final ProductArgument args;

  const AddProduct({ this.args});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _product = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.args.update?"Update Product":"Add Product"}')),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue: widget.args.update ? widget.args.product.name : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Product Name'),
                  onSaved: (value) {
                    setState(() {
                      this._product["name"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.update ? widget.args.product.price : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Product Price'),
                  onSaved: (value) {
                    this._product["price"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.update
                      ? widget.args.product.description
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Product Description'),
                  onSaved: (value) {
                    setState(() {
                      this._product["description"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.update ? widget.args.product.image: '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product image';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Product Image'),
                  onSaved: (value) {
                    setState(() {
                      this._product["image"] = value;
                    });
                  }),
                  TextFormField(
                  initialValue:
                      widget.args.update ? widget.args.product.size: '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter product size';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Product Size'),
                  onSaved: (value) {
                    setState(() {
                      this._product["size"] = value;
                    });
                  }),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                              print(this._product['price']);

                      final ProductEvent event = widget.args.update
                          ? UpdateProduct(
                              Product(
                                id: widget.args.product.id,
                                name: this._product["name"],
                                price: this._product["price"],
                                description: this._product["description"],
                                image: this._product["image"],
                                size: this._product['size']
                              ),
                            )
                          : CreateProduct(
                               Product(
                                name: this._product['name'],
                                price: this._product['price'],
                                description: this._product['description'],
                                image:this._product['image'],
                                size:this._product['size'],
                              )
                          );
                      BlocProvider.of<ProductBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false);
                    }
                  },
                  label: Text('SAVE'),
                  icon: Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
