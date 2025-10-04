import 'package:flutter/material.dart';
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
      dynamic response = await apiHelper.postApi(
        url: AppUrls.createOrderUrl,
        mBodyParams: {
          "user_id": userId,
          "product_id": productId,
          "status": status,
        },
      );
      debugPrint('order response ====> $response');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchOrders({required int userId}) async {
    try {
      dynamic response = await apiHelper.postApi(
        url: AppUrls.fetchOrderUrl,
        mBodyParams: {"user_id": userId},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
