import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/core/entities/shipping_address_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/payment_section/delivery_address_card.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/payment_section/order_summury.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final orderEntityAddress = context
        .read<OrderInputEntity>()
        .shippingAddressEntity;
    final fullAddress =
        " ${orderEntityAddress.name} ${orderEntityAddress.phone} ${orderEntityAddress.address} ${orderEntityAddress.city} ${orderEntityAddress.floor}";
    return Column(
      children: [
        OrderSummary(),
        highspace(height: 20),
        DeliveryAddressCard(
          title: "shipping_address".tr(),
          address: fullAddress,
          onEdit: () {
            context.read<OrderInputEntity>().shippingAddressEntity =
                ShippingAddressEntity();
            pageController.jumpToPage(1);
          },
        ),
      ],
    );
  }
}
