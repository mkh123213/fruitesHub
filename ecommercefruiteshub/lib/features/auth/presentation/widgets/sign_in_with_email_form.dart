import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/theming/app_colors.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/widgets/password_field.dart';
import 'package:flutter/material.dart';

class SignInWithEmailForm extends StatefulWidget {
  const SignInWithEmailForm({
    super.key,
    required this.formKey,
    required this.email,
    required this.password,
  });
  final GlobalKey<FormState> formKey;
  final ValueChanged<String?> email;
  final ValueChanged<String?> password;

  @override
  State<SignInWithEmailForm> createState() => _SignInWithEmailFormState();
}

class _SignInWithEmailFormState extends State<SignInWithEmailForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
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
