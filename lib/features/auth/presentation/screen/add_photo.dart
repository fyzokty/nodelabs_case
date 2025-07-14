import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/view_config.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/lang/locale_keys.g.dart';
import '../../../../core/service/navigation_service.dart';
import '../../../../core/util/show_notification.dart';
import '../../../../shared/widget/navigatable.dart';
import '../../../../shared/widget/scaffold.dart';
import '../../../../shared/widget/top_bar.dart';
import '../bloc/auth_bloc.dart';
import '../widget/add_photo_button.dart';
import '../widget/auth_title_description.dart';
import '../widget/wide_button.dart';
import 'mixin/add_photo_mixin.dart';

class AddPhotoScreen extends StatefulWidget implements Navigatable {
  const AddPhotoScreen({super.key});

  @override
  String get name => 'AddPhoto';

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> with AddPhotoScreenMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomTopBar(title: LocaleKeys.addPhoto.tr()),
      child: Padding(
        padding: (ViewConfigConst.screenHorizontalPadding + context.screenPadding).r,
        child: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (_, state) {
              if (state is AuthFailure) {
                showError(state.message);
              }
              if (state is AuthSuccess) {
                showInfo(LocaleKeys.uploadPhoto.tr());
                NavigationService.pop();
              }
            },
            builder: (_, state) {
              return ValueListenableBuilder(
                valueListenable: imagePath,
                builder: (_, path, _) {
                  return Column(
                    children: [
                      35.verticalSpace,
                      AuthTitleDescription(title: LocaleKeys.addPhoto.tr(), description: LocaleKeys.lorem2.tr()),
                      48.verticalSpace,
                      AddPhotoButton(onTap: pickImageOnTap, filePath: path),
                      Spacer(),
                      WideButton(
                        loading: state is AuthLoading,
                        enabled: state is! AuthLoading && path != null,
                        onTap: uploadOnTap,
                        title: LocaleKeys.continuee.tr(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
