import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class CartRepository {
  ApiHelper apiHelper;

  CartRepository({required this.apiHelper});

  Future<dynamic> addProductIntoCart({
    required int productId,
    required int qty,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.addToCartUrl,
        mBodyParams: {"product_id": productId, "quantity": qty},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateQtyCart({
    required int userId,
    required int productId,
    required int qty,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.updateQtyUrl,
        mBodyParams: {
          "user_id": userId,
          "product_id": productId,
          "quantity": qty,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchCartItems() async {
    try {
      return await apiHelper.getApi(url: AppUrls.fetchCartUrl);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteProductFromCart({required int cartId}) async {
    try {
      dynamic response = await apiHelper.postApi(
        url: AppUrls.deleteFromCartUrl,
        mBodyParams: {"cart_id": cartId},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
