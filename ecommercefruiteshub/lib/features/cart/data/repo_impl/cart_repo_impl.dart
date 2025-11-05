import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/repo_interface/cart_repo_interface.dart';

class CartRepoImpl implements CartRepoInterface {
  final CartEntity cartEntity;

  CartRepoImpl({required this.cartEntity});
  @override
  CartEntity addToCart({required CartItemEntity cartItem}) {
    if (cartEntity.items.contains(cartItem)) {
      final selectedCartEntity = cartEntity.items.firstWhere((element) {
        return element.productEntity.name == cartItem.productEntity.name;
      });
      final selectedIndex = cartEntity.items.indexOf(selectedCartEntity);
      final oldQuantity = cartEntity.items[selectedIndex].quantity;
      cartEntity.items[selectedIndex] = cartEntity.items[selectedIndex]
          .copyWith(quantity: oldQuantity + 1);

      return cartEntity;
    } else {
      cartEntity.items.add(cartItem);
      return cartEntity;
    }
  }

  @override
  CartEntity removeFromCart({
    required CartItemEntity cartItem,
    bool? isDecrese,
  }) {
    if (isDecrese == true) {
      final selectedCartEntity = cartEntity.items.firstWhere((element) {
        return element.productEntity.name == cartItem.productEntity.name;
      });
      final selectedIndex = cartEntity.items.indexOf(selectedCartEntity);
      final oldQuantity = cartEntity.items[selectedIndex].quantity;
      if (oldQuantity > 1) {
        cartEntity.items[selectedIndex] = cartEntity.items[selectedIndex]
            .copyWith(quantity: oldQuantity - 1);
        return cartEntity;
      } else {
        cartEntity.items.remove(cartItem);
        return cartEntity;
      }
    } else {
      cartEntity.items.remove(cartItem);
      return cartEntity;
    }
  }
}
