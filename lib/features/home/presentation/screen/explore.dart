import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/util/show_notification.dart';
import '../../../../shared/widget/loading_indicator.dart';
import '../bloc/home_bloc.dart';
import '../widget/explore_item.dart';
import 'mixin/explore_mixin.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with AutomaticKeepAliveClientMixin, ExploreMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      backgroundColor: ColorConst.background,
      color: ColorConst.white,
      onRefresh: onRefresh,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeFirstFailure) {
            showError(state.message);
          }
        },
        builder: (context, state) {
          if (state is HomeFirstLoading) {
            return Center(child: LoadingIndicator());
          }
          if (state is HomeFirstFailure) {
            return Center(child: Text(state.message));
          }
          final bloc = context.read<HomeBloc>();
          return PageView.builder(
            itemCount: bloc.movieList.length,
            controller: pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ExploreItem(movie: bloc.movieList[index], index: index);
            },
          );
        },
      ),
    );
  }
}
