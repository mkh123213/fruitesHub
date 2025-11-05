import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameEmailForm extends StatelessWidget {
  const NameEmailForm({
    super.key,
    this.onSavedName,
    this.onSavedEmail,
    required this.formKey,
    required this.notifier,
    required this.onSavedPassword,
  });

  final Function(String?)? onSavedName;
  final Function(String?)? onSavedEmail;
  final Function(String?)? onSavedPassword;
  final GlobalKey<FormState> formKey;

  final ValueNotifier<AutovalidateMode> notifier;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MainProfileCubit>(context);

    // bool readOnly = cubit.editNameAndEmailFileds;

    return ValueListenableBuilder<AutovalidateMode>(
      valueListenable: notifier,
      builder: (context, value, child) => Form(
        key: formKey,
        autovalidateMode: notifier.value,
        child: BlocConsumer<MainProfileCubit, MainProfileState>(
          listenWhen: (previous, current) =>
              current is UpdateNameAndEmailSuccess ||
              current is UpdateNameAndEmailError,
          listener: (context, state) {
            if (state is UpdateNameAndEmailSuccess) {
              cubit.toggelNameAndEmailFileds();
            }
            if (state is UpdateNameAndEmailError) {
              showBar(context, state.message);
            }
          },
          bloc: cubit,
          buildWhen: (previous, current) =>
              (current is EditNameAndEmailFileds &&
                  previous is! UpdateNameAndEmailSuccess) ||
              current is UpdateNameAndEmailLoading ||
              current is UpdateNameAndEmailError ||
              current is UpdateNameAndEmailSuccess,
          builder: (context, state) {
            return IntrinsicHeight(
              child: CustomProgressHud(
                isLoading: state is UpdateNameAndEmailLoading,
                child: Column(
                  children: [
                    CustomTextFormFilled(
                      formType: FormType.text,
                      onSaved: onSavedName,
                      icon: SizedBox(),
                      hintText: getUser().name,
                      readOnly: cubit.editNameAndEmailFileds,
                    ),
                    highspace(height: 20),
                    CustomTextFormFilled(
                      formType: FormType.email,
                      onSaved: onSavedEmail,
                      icon: SizedBox(),
                      hintText: getUser().email,
                      readOnly: cubit.editNameAndEmailFileds,
                    ),
                    highspace(height: 20),
                    CustomTextFormFilled(
                      formType: FormType.password,
                      onSaved: onSavedPassword,
                      icon: SizedBox(),
                      hintText: "password is required to update ",
                      readOnly: cubit.editNameAndEmailFileds,
                    ),
                    Visibility(
                      visible: Prefs.getBool(kIsNameAndEmailUpdated) == true,

                      child: Text("You have to verify your email first"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
