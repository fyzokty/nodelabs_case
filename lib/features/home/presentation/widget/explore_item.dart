import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/asset.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/util/check_http_string.dart';
import '../../../../shared/widget/loading_indicator.dart';
import '../../../../shared/widget/scale_button.dart';
import '../../domain/entity/movie.dart';
import '../bloc/home_bloc.dart';

class ExploreItem extends StatefulWidget {
  final Movie movie;
  final int index;
  const ExploreItem({super.key, required this.movie, required this.index});

  @override
  State<ExploreItem> createState() => _ExploreItemState();
}

class _ExploreItemState extends State<ExploreItem> with AutomaticKeepAliveClientMixin {
  final ValueNotifier<bool> collapsedNotifier = ValueNotifier(true);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: checkHttpsString(widget.movie.poster),
            fit: BoxFit.cover,
            fadeOutDuration: Duration.zero,
            progressIndicatorBuilder: (context, url, progress) {
              return Center(child: LoadingIndicator());
            },
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final isActive = widget.index == context.read<HomeBloc>().activePageViewIndex;
            return Positioned.fill(
              child: AnimatedContainer(
                duration: Durations.medium2,
                color: isActive ? Colors.transparent : ColorConst.fieldFill,
              ),
            );
          },
        ),
        Positioned.fill(
          child: ValueListenableBuilder(
            valueListenable: collapsedNotifier,
            builder: (_, isCollapsed, _) {
              return GestureDetector(
                onTap: () {
                  if (collapsedNotifier.value) return;
                  collapsedNotifier.value = true;
                },
                child: AnimatedContainer(
                  duration: Durations.medium4,
                  decoration: BoxDecoration(
                    color: !isCollapsed ? ColorConst.background.withAlpha(180) : Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ),

        //FOREGROUND
        Align(
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConst.background, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                16.horizontalSpace,
                Expanded(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: collapsedNotifier,
                    builder: (_, value, _) {
                      return GestureDetector(
                        onTap: () {
                          collapsedNotifier.value = !value;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(),
                            Text(widget.movie.title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
                            10.verticalSpace,
                            AnimatedSize(
                              duration: Durations.medium1,
                              alignment: Alignment.topCenter,
                              child: Text(
                                widget.movie.plot,
                                maxLines: value ? 2 : null,
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ),
                            20.verticalSpace,
                          ],
                        ),
                      );
                    },
                  ),
                ),
                16.horizontalSpace,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [LikeButton(movieID: widget.movie.id), 100.verticalSpace],
                ),
                16.horizontalSpace,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({required this.movieID, this.square = false});

  final String movieID;
  final bool square;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () {
        context.read<HomeBloc>().add(HomeFavoriteMovie(movieID));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3000),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: square ? 48.w : 70.h,
            width: square ? 48.w : 50.w,
            decoration: BoxDecoration(
              color: square ? ColorConst.fieldStroke : ColorConst.fieldFill,
              borderRadius: BorderRadius.circular(3000),
              border: Border.all(color: ColorConst.fieldStroke),
            ),
            child: Center(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(ColorConst.white, BlendMode.srcIn),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    final liked =
                        context
                            .read<HomeBloc>()
                            .favoriteList
                            .where((element) => element.id == movieID)
                            .toList()
                            .isNotEmpty;
                    return SvgPicture.asset(liked ? AssetConst.heartFilledSVG : AssetConst.heartSVG);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
