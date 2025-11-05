import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class PristantBottomNavBarEntity {
  final int index;
  final String title;
  final String activeIcon;
  final String inActiveIcon;
  final Color activeColorPrimary;
  final Color inactiveColorPrimary;

  PristantBottomNavBarEntity({
    this.activeColorPrimary = AppColors.primaryColor,
    this.inactiveColorPrimary = AppColors.grey,
    required this.index,
    required this.title,
    required this.activeIcon,
    required this.inActiveIcon,
  });
}

List<PristantBottomNavBarEntity> pristantBottomNavBarEntities = [
  PristantBottomNavBarEntity(
    index: 0,
    title: "home",
    activeIcon: Assets.imagesVuesaxBoldHome,
    inActiveIcon: Assets.imagesVuesaxOutlineHome,
  ),

  PristantBottomNavBarEntity(
    index: 0,
    title: "products",
    activeIcon: Assets.imagesVuesaxBoldProducts,
    inActiveIcon: Assets.imagesVuesaxOutlineProducts,
  ),

  PristantBottomNavBarEntity(
    index: 0,
    title: "cart",
    activeIcon: Assets.imagesVuesaxBoldShoppingCart,
    inActiveIcon: Assets.imagesVuesaxOutlineShoppingCart,
  ),

  PristantBottomNavBarEntity(
    index: 0,
    title: "profile",
    activeIcon: Assets.imagesVuesaxBoldUser,
    inActiveIcon: Assets.imagesVuesaxOutlineUser,
  ),
];
