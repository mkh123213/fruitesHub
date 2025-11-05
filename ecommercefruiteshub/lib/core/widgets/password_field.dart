import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, this.onSaved, this.hintText, this.readOnly});

  final void Function(String?)? onSaved;
  final String? hintText;
  final bool? readOnly;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormFilled(
      formType: FormType.password,
      readOnly: widget.readOnly ?? false,
      icon: SizedBox(),
      obscureText: obscureText,
      onSaved: widget.onSaved,
      haveSufficIcon: true,
      suffixIcon: GestureDetector(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: obscureText
            ? const Icon(Icons.remove_red_eye, color: Color(0xffC9CECF))
            : const Icon(Icons.visibility_off, color: Color(0xffC9CECF)),
      ),
      hintText: widget.hintText ?? 'كلمة المرور',
    );
  }
}
