import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSwitch extends StatelessWidget {
  final double size;
  final bool value; // Initial state
  final ValueChanged<bool> onChanged; // Callback to notify parent widget

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.size = 20,
  }) : super(key: key);

  // late bool widget.value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
        // widget.onChanged(_isOn); // Notify parent about the change
      },
      child: value
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(Assets.imagesToggelRememberMeIconOn),
            )
          : FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(Assets.imagesToggelRememberMeIconOff),
            ),
    );
  }
}
