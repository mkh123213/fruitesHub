import 'package:ecommercefruiteshub/core/entities/product_entity.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_network_image.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_item_entity.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/cubit/cubit/cart_entity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:svg_flutter/svg.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.productEntity});

  final ProductEntity productEntity;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return Container(
          height: c.maxHeight,
          width: c.maxWidth,
          decoration: ShapeDecoration(
            color: const Color(0xFFF3F5F7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_outline),
                ),
              ),
              Positioned.fill(
                child: Column(
                  children: [
                    highspace(height: 20),
                    productEntity.imageUrl != null
                        ? Expanded(
                            flex: 1,
                            child: CustomNetworkImage(
                              imageUrl: productEntity.imageUrl!,
                            ),
                          )
                        : Container(
                            color: Colors.grey,
                            height: 100,
                            width: 100,
                          ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          productEntity.name,
                          textAlign: TextAlign.right,
                          style: TextStyles.semiBold16,
                        ),
                        subtitle: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${productEntity.price}جنية ',
                                style: TextStyles.bold13.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              TextSpan(
                                text: '/',
                                style: TextStyles.bold13.copyWith(
                                  color: AppColors.lightSecondaryColor,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyles.semiBold13.copyWith(
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              TextSpan(
                                text: 'كيلو',
                                style: TextStyles.semiBold13.copyWith(
                                  color: AppColors.lightSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            context.read<CartEntityCubit>().addToCart(
                              cartItem: CartItemEntity(
                                productEntity: productEntity,
                                quantity: 1,
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
