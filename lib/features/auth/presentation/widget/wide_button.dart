import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/view_config.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../shared/widget/loading_indicator.dart';
import '../../../../shared/widget/scale_button.dart';

class WideButton extends StatelessWidget {
  const WideButton({super.key, this.onTap, this.title, this.loading = false, this.enabled = true});

  final VoidCallback? onTap;
  final String? title;
  final bool loading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: loading ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 52.h,
        padding: 16.verticalPad,
        decoration: BoxDecoration(
          color: enabled ? ColorConst.mainRed : ColorConst.fieldFill,
          borderRadius: ViewConfigConst.borderRadiusSmall.r,
        ),
        child:
            loading
                ? LoadingIndicator()
                : Text(
                  title ?? '',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: ColorConst.white),
                ),
      ),
    );
  }
}
