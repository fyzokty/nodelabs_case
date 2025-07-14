import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';

class LimittedOfferDescritionCard extends StatelessWidget {
  const LimittedOfferDescritionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (24.verticalPad + 20.horizontalPad).r,
      decoration: BoxDecoration(
        color: ColorConst.fieldFill,
        border: Border.all(color: ColorConst.fieldStroke),
        borderRadius: BorderRadius.circular(24).r,
      ),
      child: Column(
        children: [
          Text(LocaleKeys.bonusesYouWillRecieve.tr(), style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          14.verticalSpace,
          Row(
            children: [
              Expanded(child: LimitedOfferCardItem(asset: AssetConst.diamondPNG, text: LocaleKeys.premiumAccount.tr())),
              Expanded(child: LimitedOfferCardItem(asset: AssetConst.heartsPNG, text: LocaleKeys.moreMatches.tr())),
              Expanded(child: LimitedOfferCardItem(asset: AssetConst.arrowPNG, text: LocaleKeys.highlight.tr())),
              Expanded(child: LimitedOfferCardItem(asset: AssetConst.heartPNG, text: LocaleKeys.moreLikes.tr())),
            ],
          ),
        ],
      ),
    );
  }
}

class LimitedOfferCardItem extends StatelessWidget {
  const LimitedOfferCardItem({super.key, required this.asset, required this.text});

  final String asset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55.w,
          width: 55.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: ColorConst.white),
              BoxShadow(color: ColorConst.radialGradSecondary, blurRadius: 5, spreadRadius: -2),
            ],
          ),
          child: Center(child: Image.asset(asset, width: 33.w, height: 33)),
        ),
        12.verticalSpace,
        Text('$text\n', maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 12.sp)),
      ],
    );
  }
}
