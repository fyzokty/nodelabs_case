import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../shared/widget/scaffold.dart';
import '../../../../shared/widget/scale_button.dart';
import '../../../../shared/widget/top_bar.dart';
import '../../../auth/presentation/widget/wide_button.dart';
import '../bloc/home_bloc.dart';
import '../widget/liked_movie_tile.dart';
import '../widget/profile_user_card.dart';
import 'mixin/profile_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomTopBar(
        title: LocaleKeys.profile.tr(),
        backgroundColor: ColorConst.background,
        actions: [
          ScaleButton(
            onTap: limitedOfferOnTap,
            child: Container(
              padding: 10.verticalPad + 8.horizontalPad,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3000), color: ColorConst.mainRed),
              child: Row(
                children: [
                  SvgPicture.asset(AssetConst.diamondSVG),
                  8.horizontalSpace,
                  Text(LocaleKeys.limitedOffer.tr(), style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      child: SingleChildScrollView(
        padding: kToolbarHeight.topPad + context.statusBarPadding + 20.verticalPad + context.systemNavBarPadding,
        child: Padding(
          padding: 26.horizontalPad.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<AppUserCubit, AppUserState>(listener: appUserListener, child: ProfileUserCard()),
              26.verticalSpace,
              Text(LocaleKeys.likedMovies.tr(), style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
              20.verticalSpace,
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final list = context.read<HomeBloc>().favoriteList;
                  return GridView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.57,
                      mainAxisSpacing: 12.w,
                      crossAxisSpacing: 12.w,
                    ),
                    itemBuilder: (context, index) {
                      return FavoritedMovieTile(movie: list[index]);
                    },
                  );
                },
              ),
              24.verticalSpace,
              ScaleButton(
                onTap: languageOnTap,
                child: Row(
                  children: [
                    Text('${LocaleKeys.language.tr()}: ${context.locale.languageCode.tr()}'),
                    Spacer(),
                    Switch(
                      value: context.locale.languageCode == 'tr',
                      onChanged: (value) {
                        languageOnTap();
                      },
                      activeColor: ColorConst.mainRed,
                    ),
                  ],
                ),
              ),
              24.verticalSpace,
              WideButton(onTap: logoutOnTap, title: LocaleKeys.logOut.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
