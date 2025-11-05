import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/shipping_section/custom_shipping_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingSectionBody extends StatefulWidget {
  const ShippingSectionBody({super.key});
  // final bool isSelected;

  @override
  State<ShippingSectionBody> createState() => _ShippingSectionBodyState();
}

class _ShippingSectionBodyState extends State<ShippingSectionBody>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: List.generate(2, (index) {
        return InkWell(
          onTap: () {
            currentIndex = index;
            setState(() {
              // context.read<CheckOutCubit>().changeIsCompleted(0);
              index == 0
                  ? context.read<OrderInputEntity>().payWithCash = true
                  : context.read<OrderInputEntity>().payWithCash = false;
            });
          },
          child: CustomShippingOption(
            isSelected:
                currentIndex == index, // Select the first item by default
            title: index == 0
                ? "cash".tr()
                : "online".tr(), //", // Different title for each item
            subTitle: index == 0
                ? "location".tr()
                : "another_location".tr(), // Different subtitle for each item
            price: index == 0
                ? '40 ${"currency".tr()}'
                : '50 ${"currency".tr()}', // Different price for each item
          ),
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
