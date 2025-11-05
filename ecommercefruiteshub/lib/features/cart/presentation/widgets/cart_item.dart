import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/cubit/cubit/cart_entity_cubit.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity cartItem;

  const CartItem({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Image.network(
            cartItem.productEntity.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16),
          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartItem.productEntity.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // print('delete');
                          context.read<CartEntityCubit>().removeFromCart(
                            cartItem: cartItem,
                          );
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${cartItem.quantity}',
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Counter(
                        value: cartItem.quantity,
                        onChangedvalue: (value) => print("value"),
                        onClickIncrease: () {
                          context.read<CartEntityCubit>().addToCart(
                            cartItem: cartItem,
                            isIncrese: true,
                          );
                          print('add');
                        },
                        onClickDecrese: () {
                          context.read<CartEntityCubit>().removeFromCart(
                            cartItem: cartItem,
                            isDecrese: true,
                          );
                        },
                      ),
                      Spacer(),
                      Text(
                        '${cartItem.itemPrice()}',
                        style: TextStyle(color: Colors.orange, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Quantity control
        ],
      ),
    );
  }
}
