part of 'cart_entity_cubit.dart';

sealed class CartEntityState {}

final class CartEntityInitial extends CartEntityState {}

final class AddToCart extends CartEntityState {
  final CartEntity cartItems;
  AddToCart({required this.cartItems});
}

final class IncreseCartItemCount extends CartEntityState {
  final CartEntity cartItems;
  IncreseCartItemCount({required this.cartItems});
}

final class RemoveFromCart extends CartEntityState {
  final CartEntity cartItems;
  RemoveFromCart({required this.cartItems});
}
