import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/extension/edge_insets.dart';
import '../../../../core/util/check_http_string.dart';
import '../../domain/entity/movie.dart';
import 'explore_item.dart';

class FavoritedMovieTile extends StatelessWidget {
  const FavoritedMovieTile({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8).r,
                  child: CachedNetworkImage(imageUrl: checkHttpsString(movie.poster), fit: BoxFit.cover),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(padding: 6.allPad, child: LikeButton(movieID: movie.id, square: true)),
              ),
            ],
          ),
        ),
        15.verticalSpace,
        Text(movie.title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600), maxLines: 1),
        4.verticalSpace,
        Text(movie.released, style: TextStyle(fontSize: 12.sp, color: ColorConst.greyText)),
      ],
    );
  }
}
