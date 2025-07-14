import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../explore.dart';

mixin ExploreMixin on State<ExplorePage> {
  PageController pageController = PageController();

  ValueNotifier<int> activePage = ValueNotifier(0);

  @override
  void initState() {
    pageController.addListener(pageListener);
    context.read<HomeBloc>().add(HomeFirstLoad());
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(pageListener);
    pageController.dispose();
    super.dispose();
  }

  void pageListener() {
    final page = pageController.page;
    if (page == null) return;
    if (page.round() == activePage.value) return;
    activePage.value = page.round();
    onPageChanged();
    final isNewPageNeeded = page.round() == context.read<HomeBloc>().movieList.length - 1;
    if (isNewPageNeeded) {
      onNewPageNeeded();
    }
  }

  Future<void> onRefresh() async {
    context.read<HomeBloc>().add(HomeFirstLoad());
  }

  void onPageChanged() {
    context.read<HomeBloc>().add(ExplorePageChanged(activePage.value));
  }

  void onNewPageNeeded() {
    context.read<HomeBloc>().add(ExploreLoadMore());
  }
}
