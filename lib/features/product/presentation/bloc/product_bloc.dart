import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/product/data/models/product_model.dart';
import 'package:flutter_ecom_api/features/product/domain/repositories/product_repo.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_event.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo;

  ProductBloc({required this.productRepo}) : super(ProductInitialState()) {
    on<FetchProductEvent>(fetchProductEvent);
  }

  FutureOr<void> fetchProductEvent(
    FetchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    try {
      dynamic res = await productRepo.fetchProudcts(
        categoryId: event.categoryId,
      );
      if (res['status']) {
        List<ProductModel> mProducts =
            ProductDataModel.fromJson(res).data ?? [];
        emit(ProductLoadedState(mProductList: mProducts));
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
