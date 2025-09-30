import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/category/data/models/category_model.dart';
import 'package:flutter_ecom_api/features/category/domain/repositories/category_repo.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_event.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository categoryRepository;

  CategoryBloc({required this.categoryRepository})
    : super(CategoryInitialState()) {
    on<FetchCateogryEvent>(fetchCateogryEvent);
  }

  FutureOr<void> fetchCateogryEvent(
    FetchCateogryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoadingState());
    try {
      dynamic res = await categoryRepository.fetchCategories();

      if (res['status']) {
        List<CategoryModel> mCategoryList = CategoryDataModel.fromJson(
          res,
        ).data;
        emit(CategoryLoadedState(mCategoryList: mCategoryList));
      }
    } catch (e) {
      emit(CategoryErrorState(errorMessage: e.toString()));
    }
  }
}
