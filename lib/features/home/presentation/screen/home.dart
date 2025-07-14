import 'package:flutter/material.dart';

import '../../../../shared/widget/navigatable.dart';
import '../../../../shared/widget/scaffold.dart';
import '../widget/bottom_nav_bar.dart';
import 'explore.dart';
import 'mixin/home_mixin.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget implements Navigatable {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  String get name => 'Home';
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: false,
      bottomNavBar: BottomNavBar(activeIndex: activeIndex, onItemTap: onBottomBarChanged),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [ExplorePage(), ProfilePage()],
      ),
    );
  }
}
