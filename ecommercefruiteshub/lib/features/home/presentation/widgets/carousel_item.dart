import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/carousel_back_ground_image_with_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            decoration: const ShapeDecoration(
              color: AppColors.lightBG,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
            child: Stack(
              // alignment: Alignment,
              children: [
                Positioned(
                  top: 0,
                  // right: 0,
                  left: 0,
                  bottom: 0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      Assets.imagesPageViewItem1Image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,

                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: constrains.maxWidth * .55,
                    child: CarouselBackGroundImageWithButton(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
