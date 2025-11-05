import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/repo_interface/cart_repo_interface.dart';

class AddItemToCartEntityUseCase {
  final CartRepoInterface repo;

  AddItemToCartEntityUseCase({required this.repo});

  CartEntity call({required CartItemEntity cartItemEntity}) =>
      repo.addToCart(cartItem: cartItemEntity);
}
