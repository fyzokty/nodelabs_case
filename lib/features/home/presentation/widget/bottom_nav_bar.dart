import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../shared/widget/scale_button.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.onItemTap, required this.activeIndex});

  final ValueChanged<int> onItemTap;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: context.systemNavBarPadding + 15.botPad + 10.topPad,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BottomBarItem(
              title: LocaleKeys.home.tr(),
              icon: SvgPicture.asset(activeIndex == 0 ? AssetConst.homeFilledSVG : AssetConst.homeSVG),
              isSelected: activeIndex == 0,
              onTap: () => onItemTap(0),
            ),
            16.horizontalSpace,
            _BottomBarItem(
              title: LocaleKeys.profile.tr(),
              icon: SvgPicture.asset(activeIndex == 1 ? AssetConst.profileFilledSVG : AssetConst.profileSVG),
              isSelected: activeIndex == 1,
              onTap: () => onItemTap(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({required this.title, required this.icon, required this.isSelected, this.onTap});
  final String title;
  final Widget icon;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: AnimatedContainer(
        width: 125.w,
        height: 42.h,
        duration: Durations.medium1,
        decoration: BoxDecoration(
          color: isSelected ? ColorConst.fieldFill : ColorConst.background,
          border: Border.all(color: ColorConst.fieldStroke),
          borderRadius: BorderRadius.circular(3000),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), child: icon),
            9.horizontalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w600,
                color: ColorConst.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
