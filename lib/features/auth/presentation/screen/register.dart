import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/view_config.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/util/validator.dart';
import '../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../shared/widget/navigatable.dart';
import '../../../../shared/widget/scaffold.dart';
import '../../../../shared/widget/scale_button.dart';
import '../bloc/auth_bloc.dart';
import '../widget/auth_animated_visibilty.dart';
import '../widget/auth_field.dart';
import '../widget/auth_title_description.dart';
import '../widget/square_icon_button.dart';
import '../widget/wide_button.dart';
import 'mixin/register_mixin.dart';

class RegisterScreen extends StatefulWidget implements Navigatable {
  const RegisterScreen({super.key});

  @override
  String get name => 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with RegisterScreenMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Padding(
        padding: (ViewConfigConst.screenHorizontalPadding + context.screenPadding).r,
        child: BlocListener<AppUserCubit, AppUserState>(
          listener: appUserListener,
          child: Column(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: formFocused,
                builder: (_, isFocused, _) {
                  return AuthAnimatedVisibilty(
                    visible: !isFocused,
                    visibleHeight: 240.h,
                    hiddenHeight: 60.h,
                    child: Column(
                      children: [
                        Spacer(),
                        AuthTitleDescription(title: LocaleKeys.wellcome.tr(), description: LocaleKeys.lorem1.tr()),
                        40.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthFormField(
                      controller: fullnameCont,
                      node: fullnameNode,
                      textCapitalization: TextCapitalization.words,
                      leading: SizedBox.square(
                        dimension: 18,
                        child: Center(child: SvgPicture.asset(AssetConst.addUserSVG)),
                      ),
                      hintText: LocaleKeys.fullname.tr(),
                      textInputAction: TextInputAction.next,
                      autofillHints: {AutofillHints.givenName, AutofillHints.middleName, AutofillHints.familyName},
                      keyboardType: TextInputType.name,
                      validator: AppValidator.blankValidator,
                    ),
                    AuthFormField(
                      controller: emailCont,
                      node: emailNode,
                      leading: SizedBox.square(
                        dimension: 18,
                        child: Center(child: SvgPicture.asset(AssetConst.messageSVG)),
                      ),
                      hintText: LocaleKeys.email.tr(),
                      textInputAction: TextInputAction.next,
                      autofillHints: {AutofillHints.email, AutofillHints.username},
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidator.emailValidator,
                    ),
                    ValueListenableBuilder(
                      valueListenable: obscurePassword,
                      builder: (context, value, child) {
                        return AuthFormField(
                          controller: passwordCont,
                          node: passwordNode,
                          leading: SizedBox.square(
                            dimension: 18,
                            child: Center(child: SvgPicture.asset(AssetConst.unlockSVG)),
                          ),
                          trailing: ScaleButton(
                            onTap: hideOnTap,
                            child: SizedBox.square(
                              dimension: 40,
                              child: Center(child: SvgPicture.asset(AssetConst.hideSVG)),
                            ),
                          ),
                          obscureText: value,
                          hintText: LocaleKeys.password.tr(),
                          textInputAction: TextInputAction.next,
                          autofillHints: {AutofillHints.newPassword},
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidator.blankValidator,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: obscurePassword,
                      builder: (context, value, child) {
                        return AuthFormField(
                          controller: passwordAgainCont,
                          node: passwordAgainNode,
                          leading: SizedBox.square(
                            dimension: 18,
                            child: Center(child: SvgPicture.asset(AssetConst.unlockSVG)),
                          ),
                          trailing: ScaleButton(
                            onTap: hideOnTap,
                            child: SizedBox.square(
                              dimension: 40,
                              child: Center(child: SvgPicture.asset(AssetConst.hideSVG)),
                            ),
                          ),
                          obscureText: value,
                          hintText: LocaleKeys.passwordAgain.tr(),
                          textInputAction: TextInputAction.done,
                          autofillHints: {AutofillHints.newPassword},
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => AppValidator.passwordAgainValidator(value, passwordCont.text),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: formFocused,
                builder: (_, isFocused, _) {
                  return AuthAnimatedVisibilty(
                    visible: !isFocused,
                    visibleHeight: 70.h,
                    hiddenHeight: 20.h,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ScaleButton(
                            onTap: () {},
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorConst.greyText,
                                  fontFamily: 'Euclid',
                                  fontFamilyFallback: ['NotoSans'],
                                ),
                                children: [
                                  TextSpan(
                                    text: LocaleKeys.userAgreement.tr(),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.underline,
                                      color: ColorConst.white,
                                    ),
                                    recognizer: TapGestureRecognizer()..onTap = () {},
                                  ),
                                  TextSpan(text: ' ${LocaleKeys.userAgreementDescription.tr()}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: authBlocListener,
                builder: (_, state) {
                  return WideButton(
                    loading: state is AuthLoading,
                    title: LocaleKeys.registerNow.tr(),
                    onTap: registerOnTap,
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: formFocused,
                builder: (_, isFocused, _) {
                  return AuthAnimatedVisibilty(
                    visible: !isFocused,
                    visibleHeight: 180.h,
                    hiddenHeight: 0.h,
                    child: Column(
                      children: [
                        36.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 9.w,
                          children: [
                            SquareIconButton(onTap: () {}, icon: SvgPicture.asset(AssetConst.googleSVG)),
                            SquareIconButton(onTap: () {}, icon: SvgPicture.asset(AssetConst.appleSVG)),
                            SquareIconButton(onTap: () {}, icon: SvgPicture.asset(AssetConst.facebookSVG)),
                          ],
                        ),
                        32.verticalSpace,
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorConst.greyText,
                              fontFamily: 'Euclid',
                              fontFamilyFallback: ['NotoSans'],
                            ),
                            text: '${LocaleKeys.alreadyAccount.tr()}  ',
                            children: [
                              TextSpan(
                                text: '${LocaleKeys.login.tr()}!',
                                style: TextStyle(color: ColorConst.white, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()..onTap = loginOnTap,
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
