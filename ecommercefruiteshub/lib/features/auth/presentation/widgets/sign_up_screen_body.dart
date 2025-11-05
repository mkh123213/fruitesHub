import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/hv_hvnt_rich_text.dart';
import 'package:ecommercefruiteshub/core/helper_functions/build_error_bar.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/theming/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/custom_check_box.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreenBody extends StatelessWidget {
  SignUpScreenBody({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email, password, name;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                expandedHeight: 50,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'sign_up'.tr(),
                    style: TextStyles.bold19.copyWith(fontFamily: 'Cairo'),
                  ),
                ),
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    context.locale == Locale('en')
                        ? Icons.chevron_right
                        : Icons.chevron_left,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: KPadding.horizontal16,
                  child: Column(
                    children: [
                      SignUpForm(
                        formKey: formKey,
                        email: (value) {
                          email = value!;
                        },
                        name: (value) {
                          name = value!;
                        },
                        password: (value) {
                          password = value!;
                        },
                      ),
                      highspace(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(
                            onChanged: (value) {
                              cubit.isChecked = value;
                            },
                          ),
                          widthspace(width: 10),
                          Flexible(
                            fit: FlexFit.tight,
                            child: HvHvntRichText(
                              description: "accept".tr(),
                              clickableText: "conditions".tr(),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      highspace(height: 20),
                      BlocConsumer<SignUpCubit, SignUpState>(
                        listenWhen: (previous, current) =>
                            current is SignUpWithEmailAndPasswordSuccess ||
                            current is SignUpWithEmailAndPasswordFailure,

                        listener: (context, state) {
                          if (state is SignUpWithEmailAndPasswordSuccess) {
                            // Prefs.setString(kUserData, state.user.toMap());

                            Navigator.pop(context);
                          }
                          if (state is SignUpWithEmailAndPasswordFailure) {
                            showBar(context, state.message);
                          }
                        },
                        bloc: cubit,
                        buildWhen: (previous, current) =>
                            current is SignUpWithEmailAndPasswordLoading ||
                            current is SignUpWithEmailAndPasswordSuccess ||
                            current is SignUpWithEmailAndPasswordFailure,
                        builder: (context, state) {
                          return SizedBox(
                            height: 60,
                            child: CustomProgressHud(
                              isLoading:
                                  state is SignUpWithEmailAndPasswordLoading,
                              child: CustomElevatedButton(
                                buttonText: 'sign_up'.tr(),
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    cubit.signUpWithEmailAndPassWord(
                                      name: name,
                                      email: email,
                                      password: password,
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      highspace(height: 20),
                      HvHvntRichText(
                        description: "already_have_an_account".tr(),
                        clickableText: "login".tr(),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
