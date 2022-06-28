import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_node_api/bloc/product_event.dart';
import 'package:shoe_node_api/bloc/product_state.dart';
import 'package:shoe_node_api/repository/product_repo.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo productRepo;

  ProductBloc({@required this.productRepo})
      : assert(productRepo != null),
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(event) async* {
    if (event is ProductLoad) {
      yield* mapStateToProductLoadEvent();
    } else if (event is CreateProduct) {
      yield* mapStateToProductCreateEvent(event);
    } else if (event is UpdateProduct) {
      yield* mapStateToProductUpdateEvent(event);
    } else if (event is DeleteProduct) {
      yield* mapStateToProductDeleteEvent(event);
    }
  }

  Stream<ProductState> mapStateToProductLoadEvent() async* {
    yield ProductLoading();
    try {
      final product = await productRepo.getProducts();
      yield ProductLoaded(product);
    } catch (_) {
      yield ProductLoadingFailed();
    }
  }

  Stream<ProductState> mapStateToProductCreateEvent(
      CreateProduct event) async* {
    try {
      await productRepo.createProduct(event.product);
      yield ProductLoading();
      final product = await productRepo.getProducts();
      yield ProductLoaded(product);
    } catch (_) {
      yield ProductLoadingFailed();
    }
  }

  Stream<ProductState> mapStateToProductUpdateEvent(
      UpdateProduct event) async* {
    try {
      await productRepo.updateProduct((event.product));
      yield ProductLoading();
      final product = await productRepo.getProducts();
      yield ProductLoaded(product);
    } catch (_) {
      yield ProductLoadingFailed();
    }
  }

  Stream<ProductState> mapStateToProductDeleteEvent(
      DeleteProduct event) async* {
    try {
      await productRepo.deleteProduct(event.product.id);
      yield ProductLoading();
      final product = await productRepo.getProducts();
      yield ProductLoaded(product);
    } catch (_) {
      yield ProductLoadingFailed();
    }
  }
}
