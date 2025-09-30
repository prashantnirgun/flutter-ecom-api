import 'package:flutter_ecom_api/features/order/data/models/order_model.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderSuccessState extends OrderState {
  List<Order>? mOrders;
  OrderSuccessState({this.mOrders});
}

class OrderFailureState extends OrderState {
  String errorMessage;
  OrderFailureState({required this.errorMessage});
}
