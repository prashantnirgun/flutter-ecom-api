import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class ProductRepo {
  ApiHelper apiHelper;
  ProductRepo({required this.apiHelper});
  Future<dynamic> fetchProudcts({required String categoryId}) async {
    try {
      if (categoryId == "0") {
        print('inside if = 0');
        return await apiHelper.postApi(url: AppUrls.fetchProductUrl);
      } else {
        print('inside else = $categoryId ${categoryId.runtimeType}');
        return await apiHelper.postApi(
          url: AppUrls.fetchProductUrl,
          mBodyParams: {"category_id": categoryId},
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
