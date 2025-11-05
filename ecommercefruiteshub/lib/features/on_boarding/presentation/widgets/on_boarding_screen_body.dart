import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/features/on_boarding/presentation/widgets/custom_on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreenBody extends StatefulWidget {
  const OnBoardingScreenBody({super.key});

  @override
  State<OnBoardingScreenBody> createState() => _OnBoardingScreenBodyState();
}

final PageController _controller = PageController();
List<Widget> pages = [
  CustomOnBoardingPage(
    onClickSkip: () {
      Prefs.setBool(kIsOnBoardingSeen, true);
    },
    currentPage: 0,
    backgroundImage: Assets.imagesPageViewItem1BackgroundImage,
    imgUrl: Assets.imagesPageViewItem1Image,
    title: "welcome".tr(),
    discription: "decriptionInSplash1".tr(),
  ),
  CustomOnBoardingPage(
    currentPage: 1,
    backgroundImage: Assets.imagesPageViewItem2BackgroundImage,
    imgUrl: Assets.imagesPageViewItem2Image,
    title: "enter_and_shop".tr(),
    discription: "decriptionInSplash1".tr(),
  ),
];

class _OnBoardingScreenBodyState extends State<OnBoardingScreenBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PageView.builder(
      controller: _controller,

      itemBuilder: (context, index) {
        return Stack(
          children: [
            pages[index],
            Positioned(
              bottom: size.height * 0.14,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller, // Page controller
                  count: pages.length, // Total pages
                  effect: ExpandingDotsEffect(
                    // Dots effect
                    dotHeight: 10,
                    dotWidth: 5,
                    spacing: 12,
                    radius: 10,

                    dotColor: AppColors.lightPrimaryColor,
                    activeDotColor: AppColors.primaryColor, // Active dot color
                  ),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: pages.length,
    );
  }
}
