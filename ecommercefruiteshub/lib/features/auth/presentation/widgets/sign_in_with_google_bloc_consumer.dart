import 'dart:convert';

import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/social_midia_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWithGoogleBlocConsumer extends StatelessWidget {
  const SignInWithGoogleBlocConsumer({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
          current is SignInWithGoogleError ||
          current is SignInWithGoogleSuccess ||
          current is SignInWithGoogleLoading,
      listener: (context, state) {
        if (state is SignInWithGoogleError) {
          showBar(context, state.errMessage);
        }
        if (state is SignInWithGoogleSuccess) {
          Prefs.setBool(kIsLoggedIn, true);

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.mainScreen,
            (route) => false,
          );
        }
      },
      buildWhen: (previous, current) =>
          current is SignInWithGoogleLoading ||
          current is SignInWithGoogleError ||
          current is SignInWithGoogleSuccess,
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: CustomProgressHud(
            isLoading: state is SignInWithGoogleLoading,
            child: SocialMidiaButton(
              imgUrl: Assets.imagesGoogleIcon,
              onTap: onTap,
              textButton: 'continue_with_google',
            ),
          ),
        );
      },
    );
  }
}
