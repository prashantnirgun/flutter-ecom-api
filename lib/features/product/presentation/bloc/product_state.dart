import 'package:flutter_ecom_api/features/product/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  List<ProductModel> mProductList;
  ProductLoadedState({required this.mProductList});
}

class ProductErrorState extends ProductState {
  String errorMessage;
  ProductErrorState({required this.errorMessage});
}
