import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:flutter/material.dart';

class BottomBarTransition extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const BottomBarTransition({
    required this.animation,
    required this.child,
    super.key,
  });

  @override
  State<BottomBarTransition> createState() => _BottomBarTransition();
}

class _BottomBarTransition extends State<BottomBarTransition> {
  /// Offset animation
  late final Animation<Offset> _offsetAnimation;

  /// Height animation
  late final Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(OffsetAnimation(parent: widget.animation));

    _heightAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(parent: widget.animation));
  }

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    ),
    child: Align(
      alignment: Alignment.topLeft,
      heightFactor: _heightAnimation.value,
      child: FractionalTranslation(
        translation: _offsetAnimation.value,
        child: widget.child,
      ),
    ),
  );
}
