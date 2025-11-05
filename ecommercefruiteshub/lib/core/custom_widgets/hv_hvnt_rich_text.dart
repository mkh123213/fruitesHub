import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HvHvntRichText extends StatelessWidget {
  const HvHvntRichText({
    super.key,
    required this.description,
    required this.clickableText,
    required this.onTap,
    this.descriptionStyle,
    this.clickableTextStyle,
  });
  final String description;
  final String clickableText;
  final VoidCallback onTap;
  final TextStyle? descriptionStyle;
  final TextStyle? clickableTextStyle;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: description,
        style:
            descriptionStyle ??
            TextStyles.semiBold16.copyWith(
              color: Color(0xff949D9E),
              fontFamily: "Cairo",
            ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onTap,
            text: clickableText,
            style:
                clickableTextStyle ??
                TextStyles.semiBold16.copyWith(
                  color: AppColors.lightPrimaryColor,
                  fontFamily: "Cairo",
                ),
          ),
        ],
      ),
    );
  }
}
