import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_no_results__widget.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/profile/domain/entities/order_track_entity.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/order_track_section/track_way.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:svg_flutter/svg.dart';

class OrderTrackScreenBody extends StatelessWidget {
  const OrderTrackScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: KPadding.all16,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                BlocBuilder<MainProfileCubit, MainProfileState>(
                  bloc: BlocProvider.of<MainProfileCubit>(context),
                  buildWhen: (previous, current) =>
                      current is OrderTrackLoading ||
                      current is OrderTrackLoaded ||
                      current is OrderTrackFailure ||
                      current is OrderTrackEmpty,
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
                    if (state is OrderTrackEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: CustomNoResultWidget(text: 'no_order'.tr()),
                        ),
                      );
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
            buttonText: "update_orders".tr(),
            onTap: () {
              BlocProvider.of<MainProfileCubit>(context).getOrderTrack();
            },
          ),
        ],
      ),
    );
  }
}
