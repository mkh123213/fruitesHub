// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommercefruiteshub/core/cubits/products_cubit/products_cubit.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/features/best_selling/presentations/screens/best_selling_screen.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/best_selling_headline.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/home_body_bloc_consumer.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/home_screen_app_bar.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/home_screen_carousel.dart';
import 'package:ecommercefruiteshub/features/home/presentation/widgets/home_screen_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key, required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    return Padding(
      padding: KPadding.horizontal16,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                HomeScreenAppBar(user: user),
                highspace(height: 20),
                HomeScreenSearchBar(),
                HomeScreenCarousel(),
                BestSellingHeadline(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,

                      screen: BlocProvider.value(
                        value: cubit,

                        child: BestSellingScreen(),
                      ),

                      withNavBar:
                          true, // set to false if you want to hide the bottom nav bar
                      pageTransitionAnimation: PageTransitionAnimation.fade,
                    );
                  },
                ),
                highspace(height: 20),
              ],
            ),
          ),
          HomeBodyBlocConsumer(),
        ],
      ),
    );
  }
}
