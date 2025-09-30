import 'package:flutter_ecom_api/core/constants/app_urls.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';

class UserRepository {
  ApiHelper apiHelper;

  UserRepository({required this.apiHelper});
  //Registe user
  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String password,
    required String mobileNo,
  }) async {
    try {
      return await apiHelper.postApi(
        url: AppUrls.registrationUrl,
        mBodyParams: {
          "name": name,
          "email": email,
          "password": password,
          "mobile_number": mobileNo,
        },
        isAuth: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  //login user
  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      dynamic response = await apiHelper.postApi(
        url: AppUrls.loginUrl,
        mBodyParams: {"email": email, "password": password},
        isAuth: true,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchUsers() async {
    try {
      return await apiHelper.getApi(url: AppUrls.userListUrl);
    } catch (e) {
      rethrow;
    }
  }
}
