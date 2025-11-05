import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool value = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('value = ${value}');
        value = !value;
        widget.onChanged(value);
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value ? AppColors.primaryColor : AppColors.primaryColor,
            width: 2,
          ),
        ),
        child: value ? SvgPicture.asset(Assets.imagesCheck) : null,
      ),
    );
  }
}
