import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.hasIcon = false,
    this.icon,
    this.hightOfTheButton,

    required this.buttonText,
    this.iconSize,
    this.iSTheChildOfTheButtonAsYouNeed = false,
    this.defineTheChild,
    this.onTap = _defaultCallback,
    this.buttonBackGroundColor,
    this.buttonTextStyle,
    this.borderRaduis,
  }) : assert(
         (hasIcon == true && icon != null && iconSize != null) ||
             (hasIcon == false && iSTheChildOfTheButtonAsYouNeed == false) ||
             (iSTheChildOfTheButtonAsYouNeed == true && defineTheChild != null),
       );
  static void _defaultCallback() {}
  final bool hasIcon;
  final String? icon;
  final String buttonText;
  final double? hightOfTheButton;
  final double? iconSize;
  final bool iSTheChildOfTheButtonAsYouNeed;
  final Widget? defineTheChild;
  final VoidCallback onTap;
  final Color? buttonBackGroundColor;
  final TextStyle? buttonTextStyle;
  final double? borderRaduis;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hightOfTheButton ?? 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRaduis ?? 16),
        color: Colors.red,
        gradient: LinearGradient(
          colors: [Color(0xff1B5E37), Color(0xffAEDC81)], // Gradient colors
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        // Optional: round the corners
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              buttonBackGroundColor ??
              Colors.transparent, // Make button's background transparent
          shape: RoundedRectangleBorder(
            // Match container's radius
            borderRadius: BorderRadius.circular(borderRaduis ?? 16),
          ),
          elevation: 0, // Remove elevation (shadow) for a flat look
        ),
        child: !hasIcon && !iSTheChildOfTheButtonAsYouNeed
            ? Text(
                buttonText,
                style:
                    buttonTextStyle ??
                    TextStyles.bold16.copyWith(
                      color: Colors.white,
                      fontFamily: "Cairo",
                    ),
              )
            : !iSTheChildOfTheButtonAsYouNeed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(icon ?? '', height: iconSize),
                  Spacer(),
                  Text(
                    buttonText,
                    style:
                        buttonTextStyle ??
                        TextStyles.bold16.copyWith(
                          color: Colors.white,
                          fontFamily: "Cairo",
                        ),
                  ),
                  Spacer(),
                ],
              )
            : defineTheChild,
      ),
    );
  }
}
