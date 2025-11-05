import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EasySteppetWidget extends StatelessWidget {
  const EasySteppetWidget({
    super.key,
    required this.currentStep,
    required this.onChanged,
  });
  final int currentStep;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) {
    // int currentStep = context.read<CheckOutCubit>().currentStep;
    return EasyStepper(
      enableStepTapping: true,

      disableScroll: true,
      activeStep: currentStep,

      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      padding: KPadding.all16,
      stepRadius: 28,
      finishedStepBorderColor: Colors.deepOrange,
      finishedStepTextColor: Colors.deepOrange,
      finishedStepBackgroundColor: AppColors.lightPrimaryColor,
      activeStepIconColor: Colors.deepOrange,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: currentStep >= 0 ? 1 : 0.3,
              child: Image.asset(Assets.imagesAppIcon),
            ),
          ),
          customTitle: Text('shipping'.tr(), textAlign: TextAlign.center),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: currentStep >= 1 ? 1 : 0.3,
              child: Image.asset(Assets.imagesAppIcon),
            ),
          ),
          customTitle: Text('address'.tr(), textAlign: TextAlign.center),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: currentStep >= 2 ? 1 : 0.3,
              child: Image.asset(Assets.imagesAppIcon),
            ),
          ),
          customTitle: Text('payment'.tr(), textAlign: TextAlign.center),
        ),
      ],
      onStepReached: onChanged,
    );
  }
}
