import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/check_out_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CheckOutBlocConsumer extends StatelessWidget {
  const CheckOutBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutCubit, CheckOutState>(
      bloc: context.read<CheckOutCubit>(),
      listenWhen: (previous, current) =>
          current is AddOrderLoading ||
          current is AddOrderSuccess ||
          current is AddOrderFailure,
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          showBar(context, "Order_added_successfully".tr());
        }
        if (state is AddOrderFailure) {
          showBar(context, state.message);
        }
      },
      buildWhen: (previous, current) =>
          current is AddOrderLoading ||
          current is AddOrderSuccess ||
          current is AddOrderFailure,
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AddOrderLoading,
          child: CheckOutScreenBody(),
        );
      },
    );
  }
}
