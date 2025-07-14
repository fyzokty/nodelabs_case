import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';

class OfferPackageItem extends StatelessWidget {
  const OfferPackageItem({
    super.key,
    required this.price,
    required this.per,
    required this.coin,
    required this.oldCoin,
    required this.secondayColor,
  });

  final double price;
  final int per;
  final int coin;
  final int oldCoin;

  final Color secondayColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110.w,
      height: 217.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: 15.topPad,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConst.fieldStroke),
                  borderRadius: BorderRadius.circular(16).r,
                  gradient: RadialGradient(
                    colors: [secondayColor, ColorConst.mainRed],
                    center: Alignment(-0.25, -0.6),
                    radius: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            oldCoin.toString(),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(coin.toString(), style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w900)),
                          Text(LocaleKeys.coin.tr(), style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text('₺$price', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w900)),
                        Text(LocaleKeys.weekly.tr(), style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: 15.horizontalPad + 4.verticalPad,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2000),
                boxShadow: [
                  BoxShadow(color: ColorConst.white),
                  BoxShadow(color: secondayColor, spreadRadius: -1, blurRadius: 5),
                ],
              ),
              child: Text('+%$per'),
            ),
          ),
        ],
      ),
    );
  }
}
