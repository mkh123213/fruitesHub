import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/services/get_it_service.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/features/cart/domain/entites/cart_entity.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/cubit/cubit/cart_entity_cubit.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/widgets/cart_items_list.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/core/entities/shipping_address_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/screens/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartEntityCubit>(context);
    return Padding(
      padding: KPadding.horizontal16,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: KPadding.bottom16,
              child: CustomScrollView(
                slivers: [CartItemsList(cartItems: getIt.get<CartEntity>())],
              ),
            ),
          ),
          Padding(
            padding: KPadding.bottom16,
            child: getIt.get<CartEntity>().calculateTotalPrice() != 0
                ? CustomElevatedButton(
                    buttonText:
                        '${'checkout'.tr()} ${context.watch<CartEntityCubit>().cartEntity.calculateTotalPrice()} \$',
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,

                        screen: BlocProvider.value(
                          value: cubit,

                          child: CheckOutScreen(
                            orderInputEntity: OrderInputEntity(
                              getIt.get<CartEntity>(),
                              shippingAddressEntity: ShippingAddressEntity(),
                              uID: getUser().uid,
                            ),
                          ),
                        ),

                        withNavBar:
                            true, // set to false if you want to hide the bottom nav bar
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
