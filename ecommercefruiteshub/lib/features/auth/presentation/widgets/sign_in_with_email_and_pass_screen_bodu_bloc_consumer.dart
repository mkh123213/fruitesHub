import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWithEmailAndPassScreenBodyBlocConsumer extends StatelessWidget {
  const SignInWithEmailAndPassScreenBodyBlocConsumer({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
          current is SignInWithEmailAndPasswordFailure ||
          current is SignInWithEmailAndPasswordSuccess,
      listener: (context, state) {
        if (state is SignInWithEmailAndPasswordFailure) {
          showBar(context, state.message);
        }

        if (state is SignInWithEmailAndPasswordSuccess) {
          Prefs.setBool(kIsLoggedIn, true);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.mainScreen,
            (route) => false,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is SignInWithEmailAndPasswordLoading ||
          current is SignInWithEmailAndPasswordSuccess ||
          current is SignInWithEmailAndPasswordFailure,
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: CustomProgressHud(
            isLoading: state is SignInWithEmailAndPasswordLoading,
            child: CustomElevatedButton(
              onTap: onTap,
              buttonText: 'login'.tr(),
              buttonTextStyle: TextStyles.semiBold16.copyWith(
                fontFamily: "Cairo",
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
