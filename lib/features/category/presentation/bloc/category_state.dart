import 'package:flutter_ecom_api/features/category/data/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitialState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<CategoryModel> mCategoryList;
  CategoryLoadedState({required this.mCategoryList});
}

class CategoryErrorState extends CategoryState {
  String errorMessage;
  CategoryErrorState({required this.errorMessage});
}
