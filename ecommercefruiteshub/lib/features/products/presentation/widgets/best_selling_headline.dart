import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class ProductsNumberWithFiltterHeadLine extends StatelessWidget {
  const ProductsNumberWithFiltterHeadLine({
    super.key,
    required this.onTap,
    required this.count,
  });
  final VoidCallback onTap;
  final int count;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Row(
            children: [
              Text('products_count'.tr(), style: TextStyles.bold16),
              widthspace(width: 5),
              Text(
                '$count',
                style: TextStyles.bold16.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          Spacer(),
          SvgPicture.asset(Assets.imagesFilter2),
        ],
      ),
    );
  }
}
