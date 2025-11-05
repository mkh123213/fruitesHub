import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/services/get_it_service.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/core/widgets/build_app_bar.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/order_track_section/order_track_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackScreen extends StatelessWidget {
  const OrderTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: "order_track".tr(),
        showBackButton: true,
      ),
      body: OrderTrackScreenBody(),
    );
  }
}
