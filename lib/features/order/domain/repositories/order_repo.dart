import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class OrderRepository {
  ApiHelper apiHelper;

  OrderRepository({required this.apiHelper});

  Future<dynamic> createOrder({
    required int status,
    required int productId,
    required int userId,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.createOrderUrl,
        mBodyParams: {
          "user_id": userId,
          "product_id": productId,
          "status": status,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchOrders() async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.fetchOrderUrl,
        mBodyParams: {"user_id": 231},
      );
    } catch (e) {
      rethrow;
    }
  }
}
