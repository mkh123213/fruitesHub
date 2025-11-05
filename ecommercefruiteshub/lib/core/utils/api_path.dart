// class BackendEndpoint {
//   static const addUserData = 'users';
//   static const getUsersData = 'users';
//   static const getProducts = 'products';
//   static const isUserExists = 'users';
//   static const addOrder = 'Orders';
// }
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
  static String getCartList({required String userId}) => "users/$userId/cart";
  static String products() => "products";
  static String categories() => "categories";
  static String carousel() => "carousel";
  static String product({required String productId}) => "products/$productId";
  static String faviourate({
    required String userId,
    required String productId,
  }) => "users/$userId/faviourates/$productId";
  static String faviourates({required String userId}) =>
      "users/$userId/faviourates";
}
