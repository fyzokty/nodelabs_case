import 'package:flutter/material.dart';

class ScaleButton extends StatefulWidget {
  const ScaleButton({super.key, this.onTap, this.child});

  final VoidCallback? onTap;
  final Widget? child;

  @override
  State<ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<ScaleButton> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  bool canTap = true;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Durations.short1,
      reverseDuration: Durations.short4,
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.95).animate(animationController);
    opacityAnimation = Tween<double>(begin: 1, end: 0.40).animate(animationController);
    canTap = widget.onTap != null;
    super.initState();
  }

  @override
  void dispose() {
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap:
              canTap
                  ? () {
                    widget.onTap?.call();
                  }
                  : null,
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: onTapUp,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Opacity(opacity: opacityAnimation.value, child: widget.child),
          ),
        );
      },
    );
  }

  void onTapDown([TapDownDetails? details]) {
    if (widget.onTap == null) return;
    if (animationController.isAnimating) {
      animationController.stop();
    }
    animationController.forward();
  }

  void onTapUp([TapUpDetails? details]) {
    if (widget.onTap == null) return;
    animationController.reverse();
  }
}
