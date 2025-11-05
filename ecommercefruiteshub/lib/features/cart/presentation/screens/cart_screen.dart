import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_app_bar.dart';
import 'package:ecommercefruiteshub/features/cart/presentation/widgets/cart_screen_body.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: "cart".tr(), showBackButton: false),
      body: CartScreenBody(),
    );
  }
}
