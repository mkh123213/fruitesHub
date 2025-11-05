import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomNoResultWidget extends StatelessWidget {
  const CustomNoResultWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(Assets.noSearchResult),
          SizedBox(height: 20),
          Text(text),
        ],
      ),
    );
  }
}
