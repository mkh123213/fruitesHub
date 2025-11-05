import 'package:ecommercefruiteshub/core/helper_functions/get_order_svg.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class TrackWay extends StatelessWidget {
  const TrackWay({super.key, required this.track});
  final List<OrderTrack> track;
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      separatorBuilder: (context, index) => Padding(
        padding: KPadding.horizontal16,
        child: Divider(color: AppColors.grey, thickness: 2),
      ),
      itemCount: track.length,
      itemBuilder: (context, index) {
        // final step = steps[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              // Circle Indicator for each step
              CircleAvatar(
                radius: 18,
                // backgroundColor: AppColors.lightPrimaryColor,
                child: getSvg(index: index),
              ),
              SizedBox(width: 16),
              // Step Text and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track[index].uid,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    track[index].date,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
