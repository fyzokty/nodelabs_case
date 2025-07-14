import 'package:flutter/material.dart';

import '../home.dart';

mixin HomeMixin on State<HomeScreen> {
  PageController pageController = PageController();
  int activeIndex = 0;

  void onBottomBarChanged(int index) {
    if (index == activeIndex) return;
    activeIndex = index;
    pageController.jumpToPage(activeIndex);
    setState(() {});
  }
}
