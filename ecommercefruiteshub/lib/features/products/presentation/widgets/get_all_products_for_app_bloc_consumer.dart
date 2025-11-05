import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_sliver_grid.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_dummy_product.dart';
import 'package:ecommercefruiteshub/core/widgets/fruit_item.dart';
import 'package:ecommercefruiteshub/features/products/presentation/widgets/products_screen_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GetAllProductsForAppBlocConsumer extends StatelessWidget {
  const GetAllProductsForAppBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductsScreenBlocConsumer();
  }
}
