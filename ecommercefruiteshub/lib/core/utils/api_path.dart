class ApiPath {
  static String users({required String userId}) => "users/$userId";
  static String addOrders({required String orderId, required String userId}) =>
      "users/$userId/orders/$orderId";
  static String getOrderTrack({required String orderIdOrUserId}) =>
      "users/$orderIdOrUserId/orders";
  static String addToCart({
    required String userId,
    required String cartItemIdtId,
  }) => "users/$userId/cart/$cartItemIdtId";
  static String products() => "products";
}
