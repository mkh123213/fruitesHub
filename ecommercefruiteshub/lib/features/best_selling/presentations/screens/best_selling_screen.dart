import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/widgets/build_app_bar.dart';
import 'package:ecommercefruiteshub/features/best_selling/presentations/widgets/best_selling_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellingScreen extends StatelessWidget {
  const BestSellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsCubit>(context).getBestSellingProducts();
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: "best_selling".tr(),
        showBackButton: true,
      ),
      body: BestSellingScreenBody(),
    );
  }
}
