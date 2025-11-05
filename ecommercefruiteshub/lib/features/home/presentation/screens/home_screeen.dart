import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/services/get_it_service.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ProductsCubit>()..getAllProducts(),
      child: SafeArea(child: HomeScreenBody(user: user)),
    );
  }
}
