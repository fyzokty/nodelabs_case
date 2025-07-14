import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../shared/widget/navigatable.dart';
import '../../../auth/presentation/widget/wide_button.dart';
import 'limited_offer_description_card.dart';
import 'offer_package_item.dart';

class LimitedOfferBottomSheet extends StatelessWidget implements Navigatable {
  const LimitedOfferBottomSheet({super.key});

  @override
  String get name => 'LimitedOfferBottomSheet';

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConst.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)).r,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)).r,
          child: Stack(
            children: [
              Positioned(
                top: -83.h,
                left: 0.2.sw,
                height: 217.w,
                width: 217.w,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConst.mainRed.withAlpha(56)),
                  child: SizedBox.square(
                    dimension: 150.w,
                    child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: SizedBox()),
                  ),
                ),
              ),
              Positioned(
                bottom: -83.h,
                left: 0.2.sw,
                height: 217.w,
                width: 217.w,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConst.mainRed.withAlpha(56)),
                  child: SizedBox.square(
                    dimension: 150.w,
                    child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: SizedBox()),
                  ),
                ),
              ),
              Padding(
                padding: 18.horizontalPad.r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    24.verticalSpace,
                    Text(LocaleKeys.limitedOffer.tr(), style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600)),
                    4.verticalSpace,
                    Padding(
                      padding: 70.horizontalPad,
                      child: Text(
                        LocaleKeys.limitedOfferDescription.tr(),
                        style: TextStyle(fontSize: 12.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    12.verticalSpace,
                    LimittedOfferDescritionCard(),
                    21.verticalSpace,
                    Text(
                      LocaleKeys.coinPackDescription.tr(),
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    16.verticalSpace,
                    Row(
                      spacing: 16.w,
                      children: [
                        Expanded(
                          child: OfferPackageItem(
                            price: 99.99,
                            per: 10,
                            coin: 330,
                            oldCoin: 200,
                            secondayColor: ColorConst.radialGradSecondary,
                          ),
                        ),
                        Expanded(
                          child: OfferPackageItem(
                            price: 799.99,
                            per: 70,
                            coin: 3370,
                            oldCoin: 2000,
                            secondayColor: ColorConst.radialGradAccent,
                          ),
                        ),
                        Expanded(
                          child: OfferPackageItem(
                            price: 799.99,
                            per: 35,
                            coin: 1350,
                            oldCoin: 1000,
                            secondayColor: ColorConst.radialGradSecondary,
                          ),
                        ),
                      ],
                    ),
                    18.verticalSpace,
                    WideButton(onTap: () {}, title: LocaleKeys.seeMoreCoin.tr()),
                    5.verticalSpace,
                    context.systemNavBarBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
