import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/cart/data/models/cart_model.dart';
import 'package:flutter_ecom_api/features/cart/domain/repositories/cart_repo.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_event.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.addProductIntoCart(
          productId: event.productId,
          qty: event.qty,
        );

        if (res["status"] == "true" || res["status"]) {
          emit(CartSuccessState());
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<UpdateQtyEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.updateQtyCart(
          userId: event.userId,
          productId: event.productId,
          qty: event.qty,
        );

        if (res["status"] == "true" || res["status"]) {
          add(FetchCartEvent());
          //emit(CartSuccessState());
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<FetchCartEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.fetchCartItems();

        if (res["status"] == "true" || res["status"]) {
          CartResponse response = CartResponse.fromJson(res);

          List<CartItem> cartList = response.data;

          emit(CartSuccessState(mCartItems: cartList));
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });

    on<DeleteFromCartEvent>((event, emit) async {
      emit(CartLoadingState());

      try {
        dynamic res = await cartRepository.deleteProductFromCart(
          cartId: event.cartId,
        );
        if (res["status"] == "true" || res["status"]) {
          add(FetchCartEvent());

          //emit(CartSuccessState());
        } else {
          emit(CartFailureState(errorMsg: res["message"]));
        }
      } catch (e) {
        emit(CartFailureState(errorMsg: e.toString()));
      }
    });
  }
}
