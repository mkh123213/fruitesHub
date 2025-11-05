import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class HeadlineToUpdate extends StatelessWidget {
  const HeadlineToUpdate({
    super.key,

    required this.title,
    required this.onStartEditing,
    required this.onFinishEditing,
    this.isEditing = true,
  });

  final String title;
  final VoidCallback onStartEditing;
  final VoidCallback onFinishEditing;
  final bool isEditing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyles.semiBold13),
        isEditing
            ? InkWell(
                onTap: onStartEditing,
                child: SvgPicture.asset(Assets.editSvg),
              )
            : InkWell(onTap: onFinishEditing, child: Icon(Icons.save)),
      ],
    );
  }
}
