import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/cubit/cubit/cart_entity_cubit.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key, required this.cartItems});
  final CartEntity cartItems;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) =>
          CartItem(cartItem: cartItems.items[index]),
      itemCount: cartItems.items.length,
    );
  }
}
