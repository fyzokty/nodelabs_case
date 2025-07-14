import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/constants/asset.dart';
import '../../core/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 48, this.turning = false});
  final double size;
  final bool turning;

  @override
  Widget build(BuildContext context) {
    if (turning) {
      // ignore: deprecated_member_use
      return CircularProgressIndicator(year2023: false, color: ColorConst.white);
    }
    return ColorFiltered(
      colorFilter: ColorFilter.mode(ColorConst.white, BlendMode.srcIn),
      child: Lottie.asset(AssetConst.loadingLOTTIE, height: size.w, width: size.w, repeat: true),
    );
  }
}
