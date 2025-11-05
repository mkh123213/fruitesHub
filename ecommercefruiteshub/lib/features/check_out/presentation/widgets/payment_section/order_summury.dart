import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/utils/app_decorations.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderEntity = context.read<OrderInputEntity>();
    final tax = !orderEntity.payWithCash! ? 0 : 30;
    return Container(
      decoration: AppDecorations.greyBoxDecorationUnSelected,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'order_summary'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Sub-total row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('sub_total'.tr(), style: TextStyle(fontSize: 16)),
                Text(
                  '${orderEntity.cartEntity.calculateTotalPrice()} ${"currency".tr()}'
                      .tr(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Divider(),

            // Delivery fee row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('delivery'.tr(), style: TextStyle(fontSize: 16)),
                Text(
                  '${orderEntity.calculateShippingCost()} جنيه',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Divider(),

            // Total amount row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total".tr(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${orderEntity.cartEntity.calculateTotalPrice() + orderEntity.calculateShippingCost()} جنيه',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
