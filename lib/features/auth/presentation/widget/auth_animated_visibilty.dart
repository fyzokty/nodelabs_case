import 'package:flutter/material.dart';

import '../../../../core/constants/view_config.dart';

class AuthAnimatedVisibilty extends StatelessWidget {
  const AuthAnimatedVisibilty({
    super.key,
    required this.child,
    this.visible = true,
    required this.visibleHeight,
    this.hiddenHeight = 0,
  });

  final Widget child;
  final bool visible;
  final double visibleHeight;
  final double hiddenHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      clipBehavior: Clip.antiAlias,
      duration: Durations.medium4,
      curve: ViewConfigConst.forwardCurve,
      child: AnimatedOpacity(
        duration: Durations.medium4,
        curve: ViewConfigConst.forwardCurve,
        opacity: visible ? 1 : 0,
        child: SizedBox(height: visible ? visibleHeight : hiddenHeight, child: child),
      ),
    );
  }
}
