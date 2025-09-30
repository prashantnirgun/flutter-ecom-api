import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class CategoryRepository {
  ApiHelper apiHelper;

  CategoryRepository({required this.apiHelper});
  Future<dynamic> fetchCategories() async {
    try {
      return await apiHelper.getApi(url: AppUrls.fetchCategoryUrl);
    } catch (e) {
      rethrow;
    }
  }
}
