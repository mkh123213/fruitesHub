import 'package:ecommercefruiteshub/core/services/get_it_service.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_up_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpCubit(signUpWithEmailAndPasswordUseCase: getIt()),
      child: Scaffold(body: SignUpScreenBody()),
    );
  }
}
