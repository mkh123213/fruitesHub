import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HomeScreenSearchBar extends StatelessWidget {
  const HomeScreenSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFilled(
      backGroundColor: AppColors.white,
      haveSufficIcon: true,
      suffixIcon: FittedBox(
        fit: BoxFit.scaleDown,
        child: SvgPicture.asset(Assets.imagesFilter),
      ),
      icon: FittedBox(
        fit: BoxFit.scaleDown,
        child: SvgPicture.asset(Assets.imagesSearchIcon),
      ),
      hintText: 'search'.tr(),
    );
  }
}
