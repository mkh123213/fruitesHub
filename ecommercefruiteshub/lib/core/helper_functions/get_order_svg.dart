import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:svg_flutter/svg.dart';

SvgPicture getSvg({required int index}) {
  switch (index) {
    case 0:
      return SvgPicture.asset(Assets.orderTrack);
    case 1:
      return SvgPicture.asset(Assets.orderAccepted);
    case 2:
      return SvgPicture.asset(Assets.orderTrack);
    case 3:
      return SvgPicture.asset(Assets.orderTrack);
    case 4:
      return SvgPicture.asset(Assets.orderTrack);
    case 5:
      return SvgPicture.asset(Assets.orderTrack);
    case 6:
      return SvgPicture.asset(Assets.orderTrack);
    default:
      return SvgPicture.asset('assets/svg/1.svg');
  }
}
