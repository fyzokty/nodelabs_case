import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';

class AuthTitleDescription extends StatelessWidget {
  const AuthTitleDescription({super.key, this.title = '', this.description});

  final String title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 35.horizontalPad,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: ColorConst.white),
          ),
          ...description != null
              ? [
                8.verticalSpace,
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontSize: 13.sp, color: ColorConst.white),
                ),
              ]
              : [],
        ],
      ),
    );
  }
}
