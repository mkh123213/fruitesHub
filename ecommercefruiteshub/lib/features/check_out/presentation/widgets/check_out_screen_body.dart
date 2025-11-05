import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/utils/app_keys.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/core/entities/order_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/domain/entites/paypal_payment_entity/paypal_payment_entity.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/cubit/check_out_cubit/check_out_cubit.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/address_section/address_section_body.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/easy_steppet_widget.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/payment_section/payment_section.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/shipping_section/shipping_section_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class CheckOutScreenBody extends StatefulWidget {
  @override
  _CheckOutScreenBodyState createState() => _CheckOutScreenBodyState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _CheckOutScreenBodyState extends State<CheckOutScreenBody> {
  late ValueNotifier<AutovalidateMode> notifier;
  late PageController _pageController;
  @override
  void initState() {
    print("initState");
    // TODO: implement initState
    notifier = ValueNotifier(AutovalidateMode.disabled);
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentStep = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  int _currentStep = 0;
  // List of steps to simulate your address, payment, review, etc.
  // initState() {
  //   super.initState();
  //   _currentStep = BlocProvider.of<CheckOutCubit>(context).currentStep;
  // }

  @override
  void dispose() {
    print("dispose");
    // pageController.dispose();
    notifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stepScreens = [
      ShippingSectionBody(),
      AddressSectionBody(formKey: formKey, notifier: notifier),
      PaymentSection(pageController: _pageController),
    ];
    // final cubit = BlocProvider.of<CheckOutCubit>(context);

    return Padding(
      padding: KPadding.horizontal16,
      child: Column(
        children: [
          EasySteppetWidget(
            currentStep: _currentStep,
            onChanged: (index) {
              if (index <= _currentStep) {
                _pageController.jumpToPage(index);
                // context.read<CheckOutCubit>().changePreviousState(index);
              }
              // print(currentStepw);
            },
          ),

          Expanded(
            child: SafeArea(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    SingleChildScrollView(child: stepScreens[index]),
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable user swipe (optional)
                onPageChanged: (index) {
                  setState(() => _currentStep = index);
                },
              ),
            ),
          ),
          Padding(
            padding: KPadding.bottom16,
            child: BlocConsumer<CheckOutCubit, CheckOutState>(
              listener: (context, state) {
                if (state is AddOrderFailure) {
                  showBar(context, state.message);
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  buttonText: _currentStep == 2
                      ? "pay_with_paypal".tr()
                      : "Checkout".tr(),
                  onTap: () {
                    if (_currentStep == 0) {
                      _handleShippingConditions();
                      return;
                    }

                    if (_currentStep == 1) {
                      _handleAddressConditions();
                      return;
                    }
                    if (_currentStep == 2) {
                      _handlePaymentConditions(context: context);
                      return;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddressConditions() {
    final s = context.read<OrderInputEntity>().shippingAddressEntity;
    if (formKey.currentState!.validate()) {
      if (s.address == null ||
          s.floor == null ||
          s.city == null ||
          s.email == null ||
          s.name == null ||
          s.phone == null) {
        showBar(context, "Please_select_shipping_address".tr());
      } else {
        _pageController.jumpToPage(_currentStep + 1);
        _currentStep = 2;
      }
    } else {
      notifier.value = AutovalidateMode.always;
    }
  }

  void _handleShippingConditions() {
    if (context.read<OrderInputEntity>().payWithCash != null) {
      _pageController.jumpToPage(_currentStep + 1);
      _currentStep = 1;
    } else {
      showBar(context, "Please_select_payment_method".tr());
    }
  }

  void _handlePaymentConditions({required BuildContext context}) {
    // context.read<CheckOutCubit>().addOrder(
    //   order: context.read<OrderInputEntity>(),
    // );
    var orderEntity = context.read<OrderInputEntity>();
    PaypalPaymentEntity paypalPaymentEntity = PaypalPaymentEntity.fromEntity(
      orderEntity,
    );
    var cubit = context.read<CheckOutCubit>();
    cubit.addOrder(order: orderEntity);

    // Navigator.of(context, rootNavigator: true).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return PaypalCheckoutView(
    //         sandboxMode: true,
    //         clientId: kPaypalClientId,
    //         secretKey: kPaypalSecretKey,
    //         transactions: [paypalPaymentEntity],
    //         note: "Contact us for any questions on your order.",
    //         onSuccess: (Map params) async {
    //           log("onSuccess: $params");
    //           Navigator.pop(context);
    //           cubit.addOrder(order: orderEntity);
    //           Navigator.of(
    //             context,
    //           ).pushNamed(RoutesNames.paymentSuccess, arguments: orderEntity);
    //           // print("onSuccess: $params");
    //         },
    //         onError: (error) {
    //           print("onError: $error");
    //           Navigator.pop(context);
    //         },
    //         onCancel: () {
    //           print('cancelled:');
    //         },
    //       );
    //     },
    //   ),
    // );
  }
}
