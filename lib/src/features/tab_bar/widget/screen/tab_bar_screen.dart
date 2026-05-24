import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/component/disappearing_bottom_navigation_bar.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/component/disappearing_navigation_rail.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/component/disappearing_search_button.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  final Widget child;

  const TabBarScreen({
    required this.child,
    super.key,
  });

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  /// {@macro window_size}
  late WindowSize _windowSize;

  /// Animation controller for animate navigation rail and bottom navigation bar
  late final AnimationController _animationController;

  /// Animation for navigation rail
  late final RailAnimation _railAnimation;

  /// Animation for scale search button
  late final RailFabAnimation _railFabAnimation;

  /// Animation for bottom navigation bar
  late final BarAnimation _barAnimation;

  @override
  void initState() {
    super.initState();
    _windowSize = context.readWindowSize;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: _shouldUseRail() ? 1 : 0,
      vsync: this,
    );

    _railAnimation = RailAnimation(parent: _animationController);
    _railFabAnimation = RailFabAnimation(parent: _animationController);
    _barAnimation = BarAnimation(parent: _animationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final windowSize = context.windowSize;
    if (_windowSize != windowSize) {
      _windowSize = windowSize;
      final shouldUseRail = _shouldUseRail();
      shouldUseRail ? _forwardOrCancel() : _reverseOrCancel();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _animationController,
    builder: (context, child) => Scaffold(
      body: Row(
        children: [
          DisappearingNavigationRail(
            railAnimation: _railAnimation,
            railFabAnimation: _railFabAnimation,
          ),
          Expanded(child: widget.child),
        ],
      ),
      floatingActionButton: DisappearingSearchButton.bottom(
        animation: _barAnimation,
      ),
      bottomNavigationBar: DisappearingBottomNavigationBar(
        barAnimation: _barAnimation,
      ),
    ),
    child: widget.child,
  );

  /// Return true if should use rail
  bool _shouldUseRail() {
    final shouldUseRailByWidth = _windowSize.mapWidthWithHigherFallback(
      compact: () => false,
      medium: () => false,
      extraLarge: () => true,
    );

    final shouldUseRailByHeight = _windowSize.mapHeightWithHigherFallback(
      compact: () => false,
      expanded: () => true,
    );

    final shouldUseBySize = shouldUseRailByWidth && shouldUseRailByHeight;
    return shouldUseBySize;
  }

  Future<void> _forwardOrCancel() async {
    final status = _animationController.status;
    if (status.isForwardOrCompleted) {
      return;
    }

    try {
      await _animationController.forward().orCancel;
    } on TickerCanceled {} // ignore: empty_catches
  }

  Future<void> _reverseOrCancel() async {
    final status = _animationController.status;
    if (status.isDismissed || status.isDismissed) {
      return;
    }

    try {
      await _animationController.reverse().orCancel;
    } on TickerCanceled {} // ignore: empty_catches
  }
}
