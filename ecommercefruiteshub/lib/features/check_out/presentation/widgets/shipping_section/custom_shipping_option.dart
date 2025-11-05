import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_decorations.dart';
import 'package:flutter/material.dart';

class CustomShippingOption extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final bool isSelected;

  CustomShippingOption({
    required this.isSelected,
    required this.title,
    required this.subTitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: !isSelected
          ? AppDecorations.greyBoxDecorationUnSelected
          : AppDecorations.greyBoxDecorationSelected,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, // Use title
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                subTitle, // Use subtitle
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                price, // Use price
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 10),
              Radio<bool>(
                value: true,
                groupValue: isSelected,
                onChanged: (bool? value) {
                  // Handle the change of selection
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
