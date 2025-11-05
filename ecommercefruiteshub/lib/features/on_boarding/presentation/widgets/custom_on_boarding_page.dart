import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/helper_functions/extensions.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CustomOnBoardingPage extends StatelessWidget {
  const CustomOnBoardingPage({
    super.key,
    required this.backgroundImage,
    required this.imgUrl,
    required this.title,
    required this.discription,
    required this.currentPage,
    this.onClickSkip,
    this.onClicknext,
  }) : assert(
         (currentPage == 0 && onClickSkip != null) ||
             (currentPage == 1 && onClicknext == null),
       );

  final String backgroundImage;
  final String imgUrl;
  final String title;
  final String discription;
  final int currentPage;
  final VoidCallback? onClickSkip;
  final VoidCallback? onClicknext;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .5,
          child: Stack(
            children: [
              Positioned.fill(
                top: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(imgUrl),
              ),
              Positioned(
                right: 20,
                top: 30,

                child: currentPage == 1
                    ? const SizedBox()
                    : InkWell(
                        onTap: onClickSkip,
                        child: Text('skip'.tr(), style: TextStyles.regular13),
                      ),
              ),
            ],
          ),
        ),
        highspace(height: 30),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                currentPage == 0
                    ? RichText(
                        text: TextSpan(
                          text: title,
                          style: TextStyles.bold23.copyWith(
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' Fruit ',
                              style: TextStyles.bold23.copyWith(
                                color: AppColors.lightPrimaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' HUB',
                              style: TextStyles.bold23.copyWith(
                                color: AppColors.lightSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        title,
                        style: TextStyles.bold23.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                highspace(height: 50),
                Text(
                  discription,
                  textAlign: TextAlign.center,
                  style: TextStyles.semiBold13.copyWith(fontFamily: "Cairo"),
                ),
                Spacer(),
                Visibility(
                  visible: currentPage == 1,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Padding(
                    padding: KPadding.bottom16,
                    child: CustomElevatedButton(
                      buttonText: 'next'.tr(),
                      onTap:
                          onClicknext ??
                          () {
                            context.pushNamed(RoutesNames.signIn);
                          },
                      buttonTextStyle: TextStyles.bold16.copyWith(
                        color: Colors.white,
                        fontFamily: "Cairo",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // currentPage == 0
        //     ? const SizedBox()
        //     : Padding(
        //         padding: KPadding.bottom16,
        //         child: CustomElevatedButton(
        //           buttonText: 'next'.tr(),
        //           onTap: () {},
        //           buttonTextStyle: TextStyles.bold16.copyWith(
        //             color: Colors.white,
        //             fontFamily: "Cairo",
        //           ),
        //         ),
        //       ),
      ],
    );
  }
}
