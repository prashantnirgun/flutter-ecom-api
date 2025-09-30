import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/order/data/models/order_model.dart';
import 'package:flutter_ecom_api/features/order/domain/repositories/order_repo.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_event.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitialState()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      try {
        dynamic res = await orderRepository.createOrder(
          userId: event.userId,
          productId: event.productId,
          status: event.status,
        );

        if (res["status"] == "true") {
          emit(OrderSuccessState());
        } else {
          emit(OrderFailureState(errorMessage: res["message"]));
        }
      } catch (e) {
        emit(OrderFailureState(errorMessage: e.toString()));
      }
    });

    on<FetchOrderEvent>((event, emit) async {
      emit(OrderLoadingState());

      try {
        dynamic res = await orderRepository.fetchOrders();

        if (res["status"] == "true" || res["status"]) {
          OrderResponse response = OrderResponse.fromJson(res);

          List<Order> orderList = response.orders;
          emit(OrderSuccessState(mOrders: orderList));
        } else {
          emit(OrderFailureState(errorMessage: res["message"]));
        }
      } catch (e) {
        emit(OrderFailureState(errorMessage: e.toString()));
      }
    });
  }
}
