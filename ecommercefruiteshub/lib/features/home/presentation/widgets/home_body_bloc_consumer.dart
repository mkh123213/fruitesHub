import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_sliver_grid.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_dummy_product.dart';
import 'package:ecommercefruiteshub/core/widgets/fruit_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBodyBlocConsumer extends StatelessWidget {
  const HomeBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    return BlocConsumer(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is AllProductsLoading ||
          current is AllProductsLoaded ||
          current is AllProductsFailure,
      builder: (context, state) {
        if (state is AllProductsFailure) {
          return SliverToBoxAdapter(child: Text(state.message));
        } else if (state is AllProductsLoaded) {
          return CustomSliverGrid(
            childOfSliverGridBuilder: (context, index) =>
                FruitItem(productEntity: state.products[index]),
            itemCount: state.products.length,
          );
        } else {
          return Skeletonizer.sliver(
            enabled: state is AllProductsLoading,
            child: CustomSliverGrid(
              childOfSliverGridBuilder: (context, index) =>
                  FruitItem(productEntity: getDummyProduct()),
              itemCount: 10,
            ),
          );
        }
      },
      listenWhen: (previous, current) =>
          current is AllProductsLoaded ||
          current is AllProductsLoading ||
          current is AllProductsFailure,
      listener: (context, state) {
        if (state is BestSellingFailure) {
          showBar(context, state.errMessage);
        }
      },
    );
  }
}
