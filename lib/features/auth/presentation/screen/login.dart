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
import 'mixin/login_mixin.dart';

class LoginScreen extends StatefulWidget implements Navigatable {
  const LoginScreen({super.key});

  @override
  String get name => 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginScreenMixin {
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
                    visibleHeight: 380.h,
                    hiddenHeight: 120.h,
                    child: Column(
                      children: [
                        Spacer(),
                        AuthTitleDescription(title: LocaleKeys.hello.tr(), description: LocaleKeys.lorem1.tr()),
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
                      controller: emailCont,
                      node: emailNode,
                      leading: SizedBox.square(
                        dimension: 18,
                        child: Center(child: SvgPicture.asset(AssetConst.messageSVG)),
                      ),
                      hintText: LocaleKeys.email.tr(),
                      textInputAction: TextInputAction.next,
                      autofillHints: {AutofillHints.email},
                      keyboardType: TextInputType.emailAddress,
                      validator: AppValidator.emailValidator,
                    ),
                    ValueListenableBuilder(
                      valueListenable: obscurePassword,
                      builder: (context, value, _) {
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
                          textInputAction: TextInputAction.done,
                          autofillHints: {AutofillHints.password},
                          keyboardType: TextInputType.visiblePassword,
                          validator: AppValidator.blankValidator,
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
                    visibleHeight: 60.h,
                    hiddenHeight: 20.h,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ScaleButton(
                            onTap: () {},
                            child: Text(
                              LocaleKeys.forgotPassword.tr(),
                              style: TextStyle(fontSize: 12.sp, decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  );
                },
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: authBlocListener,
                builder: (context, state) {
                  return WideButton(loading: state is AuthLoading, title: LocaleKeys.login.tr(), onTap: loginOnTap);
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
                                text: '${LocaleKeys.register.tr()}!',
                                style: TextStyle(color: ColorConst.white, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()..onTap = registerOnTap,
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
