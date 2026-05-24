import 'package:flutter/material.dart';

class AnimateSwitchLayout extends StatelessWidget {
  final Widget child;

  const AnimateSwitchLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: const Duration(milliseconds: 250),
    switchInCurve: Curves.easeInOut,
    switchOutCurve: Curves.easeInOut,
    child: child,
  );
}
