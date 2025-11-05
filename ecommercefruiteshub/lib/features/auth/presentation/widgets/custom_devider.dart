import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/social_midia_button.dart';
import 'package:flutter/material.dart';

class CustomDevider extends StatelessWidget {
  const CustomDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or'.tr(),
            style: TextStyles.semiBold16.copyWith(
              color: Color(0XFF0C0D0D),
              fontFamily: "Cairo",
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
      ],
    );
  }
}
