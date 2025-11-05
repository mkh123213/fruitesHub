import 'package:easy_localization/easy_localization.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_elevated_button.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/custom_text_form_filled.dart';
import 'package:ecommercefruiteshub/core/custom_widgets/hv_hvnt_rich_text.dart';
import 'package:ecommercefruiteshub/core/helper_functions/extensions.dart';
import 'package:ecommercefruiteshub/core/helper_functions/spacing.dart';
import 'package:ecommercefruiteshub/core/services/shared_preferences_singleton.dart';
import 'package:ecommercefruiteshub/core/utils/app_colors.dart';
import 'package:ecommercefruiteshub/core/utils/app_images.dart';
import 'package:ecommercefruiteshub/core/utils/app_text_styles.dart';
import 'package:ecommercefruiteshub/core/utils/k_padding.dart';
import 'package:ecommercefruiteshub/core/utils/routes_names.dart';
import 'package:ecommercefruiteshub/core/widgets/custom_progress_hud.dart';
import 'package:ecommercefruiteshub/features/auth/domain/entities/user_entity.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/custom_devider.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_in_with_email_and_pass_screen_bodu_bloc_consumer.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_in_with_email_form.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/sign_in_with_google_bloc_consumer.dart';
import 'package:ecommercefruiteshub/features/auth/presentation/widgets/social_midia_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreenBody extends StatelessWidget {
  SignInScreenBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String email = "";
  late String password = '';
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignInCubit>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: KPadding.horizontal16,
      child: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  pinned: true,
                  expandedHeight: size.height * .05,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'login'.tr(),
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
                  child: Column(
                    children: [
                      SignInWithEmailForm(
                        formKey: formKey,
                        email: (value) {
                          email = value!;
                        },
                        password: (value) {
                          password = value!;
                        },
                      ),
                      Padding(
                        padding: KPadding.left12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'forget_password'.tr(),
                              style: TextStyles.regular13.copyWith(
                                color: AppColors.primaryColor,
                                fontFamily: "Cairo",
                              ),
                            ),
                          ],
                        ),
                      ),
                      highspace(height: 20),
                      SignInWithEmailAndPassScreenBodyBlocConsumer(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            cubit.signInWithEmailAndPassWord(
                              email: email,
                              password: password,
                            );
                          }
                        },
                      ),
                      highspace(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HvHvntRichText(
                            description: "dont_have_account".tr(),
                            clickableText: "sign_up".tr(),
                            onTap: () {
                              context.pushNamed(RoutesNames.signup);
                            },
                            descriptionStyle: TextStyles.semiBold16.copyWith(
                              fontFamily: "Cairo",
                              color: AppColors.grey,
                            ),
                            clickableTextStyle: TextStyles.semiBold16.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      highspace(height: 20),
                      CustomDevider(),
                      highspace(height: 20),

                      SignInWithGoogleBlocConsumer(
                        onTap: () {
                          cubit.signInWithGoogle();
                        },
                      ),
                      highspace(height: 20),
                      SocialMidiaButton(
                        imgUrl: Assets.imagesFacebookIcon,
                        onTap: () {},
                        textButton: 'continue_with_facebook',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
