import 'package:ecommercefruiteshub/core/custom_widgets/custom_switch.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSwitchToSaveAddress extends StatelessWidget {
  CustomSwitchToSaveAddress({
    super.key,
    required this.formKey,
    required this.notifier,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> notifier;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutCubit, CheckOutState>(
      buildWhen: (previous, current) => current is ConfirmChangeAddress,
      builder: (context, state) {
        return CustomSwitch(
          value: context.read<CheckOutCubit>().changeAddress,
          onChanged: (value) {
            // print('"vale" ${context.read<CheckOutCubit>().isCompleted[1]}');

            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              context.read<CheckOutCubit>().changeAddressMethod();
              // context.read<CheckOutCubit>().readyToPay = true;
            } else {
              notifier.value = AutovalidateMode.always;
            }
          },
        );
      },
    );
  }
}
