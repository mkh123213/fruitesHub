import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PaymentSuccessBody extends StatelessWidget {
  const PaymentSuccessBody({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.paymentSuceess),
          highspace(height: 20),
          Text('payment_success'.tr(), style: TextStyles.bold16),
          highspace(height: 20),

          SelectableText("#$orderId", style: TextStyles.bold16),
        ],
      ),
    );
  }
}
