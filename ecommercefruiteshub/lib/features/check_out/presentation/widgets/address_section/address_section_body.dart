import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/address_section/address_form.dart';
import 'package:ecommercefruiteshub/features/check_out/presentation/widgets/address_section/save_address_bloc_consumer.dart';
import 'package:flutter/material.dart';

class AddressSectionBody extends StatelessWidget {
  const AddressSectionBody({
    super.key,
    required this.formKey,
    required this.notifier,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> notifier;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressForm(formKey: formKey, notifier: notifier),
        Row(
          children: [
            CustomSwitchToSaveAddress(formKey: formKey, notifier: notifier),
            TextButton(onPressed: () {}, child: Text("change_address".tr())),
          ],
        ),
      ],
    );
  }
}
