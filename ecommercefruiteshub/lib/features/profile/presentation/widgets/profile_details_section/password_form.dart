import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/widgets/password_field.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordForm extends StatelessWidget {
  const PasswordForm({
    super.key,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
    required this.formKey,
    required this.notifier,
  });
  final String? Function(String?)? oldPassword;
  final String? Function(String?)? newPassword;
  final String? Function(String?)? confirmNewPassword;
  final GlobalKey<FormState> formKey;
  final ValueNotifier<AutovalidateMode> notifier;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainProfileCubit, MainProfileState>(
      bloc: BlocProvider.of<MainProfileCubit>(context),
      buildWhen: (previous, current) => current is EditPassWord,
      builder: (context, state) {
        return ValueListenableBuilder<AutovalidateMode>(
          valueListenable: notifier,
          builder: (context, value, child) => Form(
            key: formKey,
            autovalidateMode: notifier.value,

            child: Column(
              children: [
                PasswordField(
                  hintText: "password".tr(),
                  onSaved: oldPassword,
                  readOnly: context.read<MainProfileCubit>().editPassword,
                ),
                highspace(height: 20),
                PasswordField(
                  hintText: "new_password".tr(),
                  onSaved: newPassword,
                  readOnly: context.read<MainProfileCubit>().editPassword,
                ),
                highspace(height: 20),
                PasswordField(
                  hintText: "re_write_new_password".tr(),
                  onSaved: confirmNewPassword,
                  readOnly: context.read<MainProfileCubit>().editPassword,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
