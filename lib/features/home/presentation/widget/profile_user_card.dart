import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/service/navigation_service.dart';
import '../../../../shared/cubits/app_user/app_user_cubit.dart';
import '../../../../shared/widget/loading_indicator.dart';
import '../../../../shared/widget/scale_button.dart';
import '../../../auth/presentation/screen/add_photo.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AppUserInitial) {
          return LoadingIndicator();
        }
        return Row(
          children: [
            Container(
              height: 62.w,
              width: 62.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider((state as AppUserLoggedIn).user.photoUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.user.name, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500), maxLines: 2),
                  Text(
                    'ID: ${state.user.id}',
                    maxLines: 2,
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500, color: ColorConst.greyText),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            ScaleButton(
              onTap: () {
                NavigationService.push(AddPhotoScreen());
              },
              child: Container(
                padding: 10.verticalPad + 20.horizontalPad,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8).r, color: ColorConst.mainRed),
                child: Text(LocaleKeys.addPhoto.tr()),
              ),
            ),
          ],
        );
      },
    );
  }
}
