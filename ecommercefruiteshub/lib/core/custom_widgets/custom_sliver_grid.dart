import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomSliverGrid extends StatelessWidget {
  const CustomSliverGrid({
    super.key,
    required this.childOfSliverGridBuilder,
    required this.itemCount,
  });
  final Widget Function(BuildContext context, int index)
  childOfSliverGridBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return childOfSliverGridBuilder(context, index);
      },
    );
  }
}
