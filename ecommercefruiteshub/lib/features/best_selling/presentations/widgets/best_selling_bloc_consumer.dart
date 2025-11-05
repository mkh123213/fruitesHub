import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_sliver_grid.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_dummy_product.dart';
import 'package:ecommercefruiteshub/core/widgets/fruit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellingBlocConsumer extends StatelessWidget {
  const BestSellingBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    return BlocConsumer(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is BestSellingLoaded ||
          current is BestSellingFailure ||
          current is BestSellingLoading,
      builder: (context, state) {
        if (state is BestSellingFailure) {
          return SliverToBoxAdapter(child: Text(state.errMessage));
        } else if (state is BestSellingLoaded) {
          return CustomSliverGrid(
            childOfSliverGridBuilder: (context, index) =>
                FruitItem(productEntity: state.products[index]),
            itemCount: state.products.length,
          );
        } else {
          return Skeletonizer.sliver(
            enabled: state is BestSellingLoading,

            child: CustomSliverGrid(
              childOfSliverGridBuilder: (context, index) =>
                  FruitItem(productEntity: getDummyProduct()),
              itemCount: 10,
            ),
          );
        }
      },
      listenWhen: (previous, current) =>
          current is BestSellingLoaded ||
          current is BestSellingFailure ||
          current is BestSellingLoading,
      listener: (context, state) {
        if (state is BestSellingFailure) {
          showBar(context, state.errMessage);
        }
      },
    );
  }
}
