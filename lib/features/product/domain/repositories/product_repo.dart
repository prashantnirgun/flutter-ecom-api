import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class ProductRepo {
  ApiHelper apiHelper;
  ProductRepo({required this.apiHelper});
  Future<dynamic> fetchProudcts({required String categoryId}) async {
    try {
      if (categoryId == "0") {
        return await apiHelper.postApi(url: AppUrls.fetchProductUrl);
      } else {
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
