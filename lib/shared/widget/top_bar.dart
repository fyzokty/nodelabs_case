import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/asset.dart';
import '../../core/constants/colors.dart';
import '../../core/service/navigation_service.dart';
import 'scale_button.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key, required this.title, this.actions = const [], this.backgroundColor});
  final String title;
  final List<Widget> actions;
  final Color? backgroundColor;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return AppBar(
      title: Text(title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
      leading: canPop ? _CustomBackButton() : null,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }
}

class _CustomBackButton extends StatelessWidget {
  const _CustomBackButton();

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () {
        NavigationService.pop();
      },
      child: Center(
        child: Container(
          height: 42.dm,
          width: 42.dm,
          decoration: BoxDecoration(
            color: ColorConst.fieldFill,
            border: Border.all(color: ColorConst.fieldStroke),
            shape: BoxShape.circle,
          ),
          child: Center(child: SvgPicture.asset(AssetConst.arrowLeftSVG, width: 20.dm, height: 20.dm)),
        ),
      ),
    );
  }
}
