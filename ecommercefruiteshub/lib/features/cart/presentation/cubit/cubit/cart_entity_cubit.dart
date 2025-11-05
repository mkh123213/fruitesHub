import 'package:ecommercefruiteshub/features/cart/data/repo_impl/cart_repo_impl.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/use_cases/add_item_to_cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/domain/use_cases/remove_item_from_cart_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_entity_state.dart';

class CartEntityCubit extends Cubit<CartEntityState> {
  CartEntityCubit({
    required this.cartEntity,
    required this.addItemToCartEntityUseCase,
    required this.removeItemFromCartEntity,
  }) : super(CartEntityInitial());
  final CartEntity cartEntity;
  final AddItemToCartEntityUseCase addItemToCartEntityUseCase;
  final RemoveItemFromCartEntity removeItemFromCartEntity;

  void addToCart({required CartItemEntity cartItem, bool isIncrese = false}) {
    final item = addItemToCartEntityUseCase.call(cartItemEntity: cartItem);
    // cartEntity.copyWith(items: item.items);
    if (!isIncrese) {
      emit(AddToCart(cartItems: item));
    } else {
      emit(IncreseCartItemCount(cartItems: item));
    }
  }

  void removeFromCart({
    required CartItemEntity cartItem,
    bool isDecrese = false,
  }) {
    final item = removeItemFromCartEntity.call(
      cartItemEntity: cartItem,
      isDecrese: isDecrese,
    );
    // cartEntity.copyWith(items: item.items);
    emit(RemoveFromCart(cartItems: item));
  }
}
