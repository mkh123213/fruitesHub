import 'package:ecommercefruiteshub/core/services/get_it_service.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_in_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        signInWithGoogleUseCase: getIt(),
        signInWithEmailAndPassword: getIt(),
      ),
      child: Scaffold(body: SignInScreenBody()),
    );
  }
}
