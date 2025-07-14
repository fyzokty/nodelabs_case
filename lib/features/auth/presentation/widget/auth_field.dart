import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    this.controller,
    this.hintText,
    this.leading,
    this.trailing,
    this.keyboardType,
    this.textInputAction,
    this.node,
    this.validator,
    this.autofillHints,
    this.obscureText = false,
    this.onTapOutside,
    this.textCapitalization = TextCapitalization.none,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? node;
  final FormFieldValidator<String>? validator;
  final Iterable<String>? autofillHints;
  final void Function(PointerDownEvent event)? onTapOutside;
  final bool obscureText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      autofillHints: autofillHints,
      cursorOpacityAnimates: true,
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: node,
      obscureText: obscureText,
      cursorColor: ColorConst.white,
      cursorErrorColor: ColorConst.mainRed,
      onTapOutside:
          onTapOutside ??
          (event) {
            FocusScope.of(context).unfocus();
          },
      decoration: InputDecoration(
        helperText: '',
        hintText: hintText,
        helperStyle: TextStyle(fontSize: 8.sp),
        errorStyle: TextStyle(fontSize: 8.sp),
        prefixIcon: leading,
        suffixIcon: trailing,
        constraints: BoxConstraints(minHeight: 56.h),
      ),
    );
  }
}
