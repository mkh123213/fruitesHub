import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/get_user.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/constants.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/cubit/cubit/main_profile_cubit.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/profile_details_section/headline_to_update.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/profile_details_section/name_email_form.dart';
import 'package:ecommercefruiteshub/features/profile/presentation/widgets/profile_details_section/password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenBody extends StatelessWidget {
  ProfileScreenBody({super.key});
  ValueNotifier<AutovalidateMode> notifierEmailAndName = ValueNotifier(
    AutovalidateMode.disabled,
  );
  ValueNotifier<AutovalidateMode> notifierPassword = ValueNotifier(
    AutovalidateMode.disabled,
  );
  late String name,
      email,
      currentPassword,
      oldPassword,
      newPassword,
      confirmNewPassword;
  GlobalKey<FormState> formKeyEmailAndName = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MainProfileCubit>(context);
    bool readOnly = cubit.editNameAndEmailFileds;
    return BlocListener<MainProfileCubit, MainProfileState>(
      listenWhen: (previous, current) =>
          current is UpdateNameAndEmailSuccess ||
          current is UpdateNameAndEmailError ||
          current is UpdateNameAndEmailLoading ||
          current is UpdatePasswordSuccess ||
          current is UpdatePasswordError ||
          current is UpdatePasswordLoading,
      listener: (context, state) {
        if (state is UpdateNameAndEmailSuccess) {
          showBar(context, "Name_and_email_updated_successfully".tr());
          Prefs.setBool(kIsNameAndEmailUpdated, true);
        }
        if (state is UpdateNameAndEmailError) {
          showBar(context, state.message);
          Prefs.setBool(kIsNameAndEmailUpdated, false);
        }

        if (state is UpdatePasswordSuccess) {
          showBar(context, "Password_updated_successfully".tr());
          Prefs.setBool(kIsPasswordUpdated, true);
        }
        if (state is UpdatePasswordError) {
          showBar(context, state.message);
          Prefs.setBool(kIsPasswordUpdated, false);
        }
      },
      child: Padding(
        padding: KPadding.all16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<MainProfileCubit, MainProfileState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    current is EditNameAndEmailFileds,
                builder: (context, state) {
                  return HeadlineToUpdate(
                    onFinishEditing: () {
                      if (formKeyEmailAndName.currentState!.validate()) {
                        formKeyEmailAndName.currentState!.save();
                        print(name);
                        print(email);
                        cubit.updateNameAndEmail(
                          name: name,
                          email: email,
                          currentPassword: currentPassword,
                        );
                      } else {
                        notifierEmailAndName.value = AutovalidateMode.always;
                      }
                    },
                    onStartEditing: () {
                      cubit.toggelNameAndEmailFileds();
                    },
                    title: 'change_name_and_email'.tr(),
                    isEditing: cubit.editNameAndEmailFileds,
                  );
                },
              ),
              highspace(height: 20),
              NameEmailForm(
                onSavedPassword: (value) => currentPassword = value!,
                formKey: formKeyEmailAndName,
                notifier: notifierEmailAndName,
                onSavedEmail: (value) => email = value!,
                onSavedName: (value) => name = value!,
              ),
              highspace(height: 20),

              BlocBuilder<MainProfileCubit, MainProfileState>(
                bloc: cubit,
                buildWhen: (previous, current) => current is EditPassWord,
                builder: (context, state) {
                  return HeadlineToUpdate(
                    isEditing: cubit.editPassword,
                    onFinishEditing: () {
                      if (formKeyPassword.currentState!.validate()) {
                        formKeyPassword.currentState!.save();

                        cubit.updatePassword(
                          newPassword: newPassword,
                          oldPassword: oldPassword,
                        );
                        cubit.toggelPassword();
                      } else {
                        notifierPassword.value = AutovalidateMode.always;
                      }
                    },
                    onStartEditing: () {
                      cubit.toggelPassword();
                    },

                    title: 'change_password'.tr(),
                  );
                },
              ),
              highspace(height: 20),
              PasswordForm(
                oldPassword: (value) => oldPassword = value!,
                newPassword: (value) => newPassword = value!,
                confirmNewPassword: (value) => confirmNewPassword = value!,
                formKey: formKeyPassword,
                notifier: notifierPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
