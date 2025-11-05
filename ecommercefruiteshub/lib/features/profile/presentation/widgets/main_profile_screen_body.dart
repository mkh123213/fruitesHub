import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_switch.dart';
import 'package:ecommercefruiteshub/core/helper_functions/extensions.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/screens/order_track_screen.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/screens/profile_screen.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/build_menu_item.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/order_track_section/order_track_screen_body.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/profile_img_picker_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainProfileScreenBody extends StatefulWidget {
  const MainProfileScreenBody({super.key});

  @override
  State<MainProfileScreenBody> createState() => _MainProfileScreenBodyState();
}

class _MainProfileScreenBodyState extends State<MainProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("my_account".tr(), style: TextStyles.semiBold16),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ProfileImgPickerBlocConsumer(),
            const SizedBox(height: 10),
            const Text(
              'أحمد ياسر',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('mail@mail.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'عام',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),

            BuildMenuItem(
              leadingWidget: Icon(Icons.person_outline),
              traillingWidget: Icon(Icons.arrow_back_ios_new),
              title: "profile".tr(),
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: BlocProvider.value(
                    value: context.read<MainProfileCubit>(),
                    child: ProfileScreen(),
                  ),
                );
              },
            ),
            BuildMenuItem(
              leadingWidget: Icon(Icons.inventory_2_outlined),
              traillingWidget: Icon(Icons.arrow_back_ios_new),
              title: "orders".tr(),
              onTap: () {
                print("orders");
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: BlocProvider.value(
                    value: context.read<MainProfileCubit>()..getOrderTrack(),
                    child: OrderTrackScreen(),
                  ),
                );
              },
            ),
            BuildMenuItem(
              leadingWidget: Icon(Icons.favorite_border),
              traillingWidget: Icon(Icons.arrow_back_ios_new),
              title: "Favourite".tr(),
              onTap: () {},
            ),
            BuildMenuItem(
              leadingWidget: Icon(Icons.notifications_none),
              traillingWidget: CustomSwitch(
                value: true,
                onChanged: (value) {
                  print(value);
                },
              ),
              title: "notifications".tr(),
              onTap: () {},
            ),
            BuildMenuItem(
              leadingWidget: Icon(Icons.language),
              traillingWidget: Icon(Icons.arrow_back_ios_new),
              title: "language".tr(),
              onTap: () {
                context.read<MainProfileCubit>().toggelLanguage(
                  context: context,
                );
              },
            ),
            BuildMenuItem(
              leadingWidget: Icon(Icons.dark_mode_outlined),
              traillingWidget: CustomSwitch(
                value: true,
                onChanged: (value) {
                  print(value);
                },
              ),
              title: "theme".tr(),
              onTap: () {},
            ),

            // _buildMenuItem(Icons.language, 'اللغة'),
            // _buildSwitchItem('الوضع', Icons.dark_mode_outlined, false),
          ],
        ),
      ),
    );
  }

  static Widget _buildSwitchItem(String title, IconData icon, bool value) {
    return SwitchListTile(
      title: Text('Enable Notifications'),
      value: value,
      onChanged: (bool value) {},
      activeColor: Colors.blue, // Customize the color when it's "on"
      inactiveThumbColor: Colors.red, // Customize the thumb when it's "off"
      inactiveTrackColor: Colors.grey, // Customize the track when it's "off"
      activeTrackColor: Colors.green, // Customize the track when it's "on"
      secondary: Icon(Icons.notifications), // Optional icon
    );
  }
}
