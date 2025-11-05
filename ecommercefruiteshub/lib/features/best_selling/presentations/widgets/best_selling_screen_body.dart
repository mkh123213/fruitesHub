import 'package:ecommercefruiteshub/features/best_selling/presentations/widgets/best_selling_bloc_consumer.dart';
import 'package:flutter/material.dart';

class BestSellingScreenBody extends StatelessWidget {
  const BestSellingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: const [BestSellingBlocConsumer()]);
  }
}
