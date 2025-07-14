import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/view_config.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../shared/widget/scale_button.dart';

class SquareIconButton extends StatelessWidget {
  const SquareIconButton({super.key, this.icon, this.iconSize = 24, this.onTap});
  final Widget? icon;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: Container(
        padding: 20.allPad,
        decoration: BoxDecoration(
          color: ColorConst.fieldFill,
          borderRadius: ViewConfigConst.borderRadiusSmall.r,
          border: Border.all(color: ColorConst.fieldStroke),
        ),
        child: SizedBox.square(dimension: iconSize.dm, child: icon),
      ),
    );
  }
}
