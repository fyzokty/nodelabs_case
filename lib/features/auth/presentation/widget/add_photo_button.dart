import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/view_config.dart';
import '../../../../shared/widget/scale_button.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({super.key, this.onTap, this.filePath});

  final VoidCallback? onTap;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: Builder(
        builder: (context) {
          if (filePath != null) {
            return SizedBox.square(
              dimension: 165.dm,
              child: ClipRRect(
                borderRadius: ViewConfigConst.borderRadiusBig,
                child: Image.file(File(filePath!), fit: BoxFit.cover),
              ),
            );
          }
          return Container(
            height: 165.dm,
            width: 165.dm,
            decoration: BoxDecoration(
              color: ColorConst.fieldFill,
              border: Border.all(color: ColorConst.fieldStroke),
              borderRadius: ViewConfigConst.borderRadiusBig,
            ),
            child: Center(child: SvgPicture.asset(AssetConst.plusSVG, height: 24.dm, width: 24.dm)),
          );
        },
      ),
    );
  }
}
