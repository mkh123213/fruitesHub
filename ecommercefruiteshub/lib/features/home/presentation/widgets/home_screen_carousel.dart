import 'package:ecommercefruiteshub/features/home/presentation/widgets/carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeScreenCarousel extends StatelessWidget {
  const HomeScreenCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: FlutterCarouselOptions(
        aspectRatio: 342 / 158,

        // height: 210,
        showIndicator: true,
        slideIndicator: CircularSlideIndicator(),
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(width: double.infinity, child: CarouselItem());
          },
        );
      }).toList(),
    );
  }
}
