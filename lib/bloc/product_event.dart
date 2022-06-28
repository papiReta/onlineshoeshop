import 'package:equatable/equatable.dart';
import 'package:shoe_node_api/model/product.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class ProductLoad extends ProductEvent {
  ProductLoad();
  @override
  List<Object> get props => [];
}

class CreateProduct extends ProductEvent {
  final Product product;

  const CreateProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'Product Created {product : $product}';
}

class UpdateProduct extends ProductEvent {
  final Product product;
  const UpdateProduct(this.product);
  @override
  List<Object> get props => [product];

  @override
  String toString() => 'Product Updated {product : $product}';
}

class DeleteProduct extends ProductEvent {
  final Product product;

  DeleteProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'Product Deleted {product : $product}';
}

