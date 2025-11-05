import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/widgets/password_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.name,
    required this.email,
    required this.password,
  });
  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> name;
  final ValueChanged<String?> email;
  final ValueChanged<String?> password;
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          CustomTextFormFilled(
            onSaved: widget.name,

            icon: SizedBox(),
            hintText: 'name'.tr(),
          ),
          highspace(height: 20),
          CustomTextFormFilled(
            onSaved: widget.email,
            icon: SizedBox(),
            hintText: 'email'.tr(),
          ),
          highspace(height: 20),
          PasswordField(onSaved: widget.password),
        ],
      ),
    );
  }
}
