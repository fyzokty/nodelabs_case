import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.child,
    this.appBar,
    this.extendBody = true,
    this.extendBodyBehindAppBar = true,
    this.bottomNavBar,
  });

  final Widget? child;
  final PreferredSizeWidget? appBar;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? bottomNavBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      bottomNavigationBar: bottomNavBar,
      body: child,
    );
  }
}
