import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommercefruiteshub/features/best_selling/presentations/screens/best_selling_screen.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/screens/check_out_screen.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/screens/payment_sucess.dart';
import 'package:ecommercefruiteshub/features/home/presentation/screens/home_screeen.dart';
import 'package:ecommercefruiteshub/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/screens/profile_screen.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/main_profile_screen_body.dart';
import 'package:ecommercefruiteshub/features/splash/presentation/screens/splash_screen.dart';
import 'package:ecommercefruiteshub/man_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesNames.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case RoutesNames.onboarding:
      return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
    case RoutesNames.signIn:
      return MaterialPageRoute(builder: (_) => const SignInScreen());
    case RoutesNames.home:
      return MaterialPageRoute(
        builder: (_) {
          // final arguments = settings.arguments as Map<String, dynamic>?;
          // print(arguments?["user"]);
          return HomeScreeen(user: getUser());
        },
      );
    case RoutesNames.signup:
      return MaterialPageRoute(
        builder: (_) {
          return SignUpScreen();
        },
      );
    case RoutesNames.mainScreen:
      return MaterialPageRoute(
        builder: (_) {
          return MainScreen();
        },
      );
    case RoutesNames.bestSelling:
      return MaterialPageRoute(
        builder: (_) {
          return BestSellingScreen();
        },
      );
    case RoutesNames.checkOut:
      return MaterialPageRoute(
        builder: (_) {
          return CheckOutScreen(
            orderInputEntity: settings.arguments as OrderInputEntity,
          );
        },
      );
    case RoutesNames.paymentSuccess:
      return MaterialPageRoute(
        builder: (_) {
          return PaymentSucess(order: settings.arguments as OrderInputEntity);
        },
      );
    case RoutesNames.mainProfileScreen:
      return MaterialPageRoute(
        builder: (_) {
          return MainProfileScreenBody();
        },
      );
    case RoutesNames.profile:
      return MaterialPageRoute(
        builder: (_) {
          return ProfileScreen();
        },
      );

    default:
      return MaterialPageRoute(builder: (_) => MainScreen());
  }
}
