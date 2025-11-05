import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class SocialMidiaButton extends StatelessWidget {
  const SocialMidiaButton({
    super.key,
    required this.onTap,
    required this.textButton,
    required this.imgUrl,
  });
  final VoidCallback onTap;
  final String textButton;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(imgUrl),
            Spacer(),

            Text(
              textButton.tr(),
              style: TextStyles.bold16.copyWith(
                color: Color(0xff0C0D0D),
                fontFamily: "Cairo",
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
