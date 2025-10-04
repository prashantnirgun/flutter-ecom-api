import 'package:flutter_ecom_api/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartSuccessState extends CartState {
  List<CartItem>? mCartItems;
  CartSuccessState({this.mCartItems});

  // ----------------- Getter to calculate total -----------------
  double get totalAmount {
    if (mCartItems == null || mCartItems!.isEmpty) return 0.0;

    double total = 0.0;
    for (var item in mCartItems!) {
      double price = double.tryParse(item.price) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }
}

class CartFailureState extends CartState {
  String errorMsg;
  CartFailureState({required this.errorMsg});
}
