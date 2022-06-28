import 'package:equatable/equatable.dart';
import 'package:shoe_node_api/model/product.dart';

class ProductState extends Equatable {
  ProductState();
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;

  ProductLoaded([this.product=const []]);
  @override
  List<Object> get props => [];
}
class ProductLoadingFailed extends ProductState{

}