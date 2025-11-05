import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/order_track_section/track_way.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderTrackScreenBody extends StatelessWidget {
  const OrderTrackScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              BlocBuilder<MainProfileCubit, MainProfileState>(
                bloc: BlocProvider.of<MainProfileCubit>(context),
                buildWhen: (previous, current) =>
                    current is OrderTrackLoading ||
                    current is OrderTrackLoaded ||
                    current is OrderTrackFailure,
                builder: (context, state) {
                  if (state is OrderTrackFailure) {
                    return SliverToBoxAdapter(child: Text(state.message));
                  }
                  if (state is OrderTrackLoading) {
                    return Skeletonizer.sliver(
                      child: TrackWay(track: getDummyTrackList()),
                    );
                  }
                  if (state is OrderTrackLoaded) {
                    return TrackWay(track: state.ordersTrackEntity);
                  }

                  return SliverToBoxAdapter(child: Text("loading".tr()));
                },
              ),
            ],
          ),
        ),

        // Expanded(
        //   child: OrderDetailsWidget(
        //     orderNumber: "#123",
        //     orderDate: DateTime.now(),
        //     price: 1263,
        //     itemCount: 10,
        //   ),
        // ),
        CustomElevatedButton(
          buttonText: "track_order".tr(),
          onTap: () {
            BlocProvider.of<MainProfileCubit>(context).getOrderTrack();
          },
        ),
      ],
    );
  }
}
