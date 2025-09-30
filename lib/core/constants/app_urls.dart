class AppUrls {
  ///https://ecommerceapi.projectnest.online/ecommerce-api/user/registration
  static const String baseUrl =
      "https://ecommerceapi.projectnest.online/ecommerce-api/";
  static const String registrationUrl = "${baseUrl}user/registration";
  static const String userListUrl = "${baseUrl}user/list";
  static const String loginUrl = "${baseUrl}user/login";

  static const String fetchCategoryUrl = "${baseUrl}categories";
  static const String fetchProductUrl = "${baseUrl}products";
  static const String addToCartUrl = "${baseUrl}add-to-cart";
  static const String deleteFromCartUrl = "${baseUrl}product/delete-cart";
  static const String fetchCartUrl = "${baseUrl}product/view-cart";
  static const String createOrderUrl = "${baseUrl}product/create-order";
  static const String fetchOrderUrl = "${baseUrl}product/get-order";
  static const String updateQtyUrl = "${baseUrl}product/decrement-quantity";
}
