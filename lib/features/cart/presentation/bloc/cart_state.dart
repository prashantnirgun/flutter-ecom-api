import 'package:flutter_ecom_api/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  List<CartItem>? mCartItems;
  CartSuccessState({this.mCartItems});
}

class CartFailureState extends CartState {
  String errorMsg;
  CartFailureState({required this.errorMsg});
}
