import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class BestSellingHeadline extends StatelessWidget {
  const BestSellingHeadline({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text('best_selling'.tr(), style: TextStyles.bold16),
          Spacer(),
          Text('see_all'.tr(), style: TextStyles.regular13),
        ],
      ),
    );
  }
}
