// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> items;

  CartEntity({required this.items}); // List<CartItemEntity

  num calculateTotalPrice() => items.fold(
    0,
    (previousValue, element) => previousValue + element.itemPrice(),
  );

  CartEntity copyWith({List<CartItemEntity>? items}) {
    return CartEntity(items: items ?? this.items);
  }
}
