import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:flutter/widgets.dart';

class NavRailTransition extends StatefulWidget {
  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;

  const NavRailTransition({
    required this.animation,
    required this.backgroundColor,
    required this.child,
    super.key,
  });

  @override
  State<NavRailTransition> createState() => _NavRailTransitionState();
}

class _NavRailTransitionState extends State<NavRailTransition> {
  /// Text direction
  late TextDirection _textDirection;

  /// Offset animation
  late Animation<Offset> _offsetAnimation;

  /// Width animation
  late Animation<double> _widthAnimation;

  /// Return begin offset for the animation based on the text direction
  Offset get beginOffset => switch (_textDirection) {
    TextDirection.ltr => const Offset(-1, 0),
    TextDirection.rtl => const Offset(1, 0),
  };

  @override
  void initState() {
    super.initState();
    _textDirection = TextDirection.ltr;
    _createAnimations();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final textDirection = Directionality.of(context);
    if (textDirection != _textDirection) {
      _textDirection = textDirection;
      _createAnimations();
    }
  }

  @override
  Widget build(BuildContext context) => ClipRect(
    child: DecoratedBox(
      decoration: BoxDecoration(color: widget.backgroundColor),
      child: AnimatedBuilder(
        animation: _widthAnimation,
        builder: (context, child) => Align(
          alignment: Alignment.topLeft,
          widthFactor: _widthAnimation.value,
          child: FractionalTranslation(
            translation: _offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    ),
  );

  /// Create animations for the widget
  void _createAnimations() {
    _offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(OffsetAnimation(parent: widget.animation));
    _widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(parent: widget.animation));
  }
}
