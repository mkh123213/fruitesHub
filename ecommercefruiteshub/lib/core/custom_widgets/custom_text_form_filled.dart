import 'package:ecommercefruiteshub/core/helper_functions/app_regex.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FormType { email, password, phoneNumber, text }

class CustomTextFormFilled extends StatelessWidget {
  const CustomTextFormFilled({
    super.key,
    required this.icon,
    this.haveSufficIcon = false,
    this.suffixIcon,
    this.hightOfTheForm,
    required this.hintText,
    this.backGroundColor,
    this.hintTextColor,
    this.phoneController,
    this.maxLines = 1,
    this.hintStyle,
    this.obscureText = false,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
    this.formType = FormType.text,
  }) : assert(
         (haveSufficIcon == false && suffixIcon == null) ||
             (haveSufficIcon && suffixIcon != null),
       );
  final Widget icon;
  final bool haveSufficIcon;
  final Widget? suffixIcon;
  final double? hightOfTheForm;
  final String hintText;
  final Color? backGroundColor;
  final Color? hintTextColor;
  final TextEditingController? phoneController;
  final int maxLines;
  final TextStyle? hintStyle;
  final bool obscureText;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String?>? onChanged;
  final bool readOnly;
  final FormType? formType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor ?? Colors.white,
      ),
      width: double.infinity,
      height: hightOfTheForm ?? 60,
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.text,
        readOnly: readOnly,
        onChanged: onChanged,
        onSaved: onSaved,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          } else if (formType == FormType.email &&
              !AppRegex.isEmailValid(value)) {
            return 'البريد الالكتروني غير صحيح';
          } else if (formType == FormType.phoneNumber &&
              !AppRegex.isPhoneNumberValid(value)) {
            return 'رقم الهاتف غير صحيح';
          } else if (formType == FormType.password &&
              !AppRegex.isPasswordValid(value)) {
            return 'كلمة المرور غير صحيح';
          }
          // if (value == null || value.isEmpty) {
          //   return 'هذا الحقل مطلوب';
          // } else if (obscureText) {
          //   if (value.length < 6) {
          //     return "كلمة المرور يجب ان تكون على الاقل 6 حروف";
          //   }
          // }
          return null;
        },
        maxLines: maxLines,

        decoration: InputDecoration(
          prefixIcon: icon,
          suffixIcon: haveSufficIcon ? suffixIcon : null,
          fillColor: backGroundColor ?? Color(0xffE6E9EA),
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
          hintStyle:
              hintStyle ??
              TextStyles.bold13.copyWith(
                color: Color(0xff949D9E),
                fontFamily: 'Cairo',
              ),
        ),
      ),
    );
  }
}
