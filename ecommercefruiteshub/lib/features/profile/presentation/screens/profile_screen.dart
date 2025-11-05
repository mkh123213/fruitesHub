import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_app_bar.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/profile_details_section/profile_screen_body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: "profile".tr(),
        showBackButton: true,
        showNotification: false,
      ),
      body: ProfileScreenBody(),
    );
  }
}
