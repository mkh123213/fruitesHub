import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(child: Image.asset(Assets.imagesProfileImage)),
        widthspace(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('welcome'.tr(), style: TextStyles.bold16),

            Flexible(
              child: Text(
                user.name,
                style: TextStyles.bold16.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.green50,
            child: SvgPicture.asset(Assets.imagesNotification),
          ),
        ),
      ],
    );
  }
}
