import 'package:aniliberty_multiplatform/src/features/search/search.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/screen/tab_bar_animations.dart';
import 'package:flutter/material.dart';

class DisappearingSearchButton extends StatefulWidget {
  final Animation<double> animation;
  final bool isRail;

  const DisappearingSearchButton.rail({
    required this.animation,
    super.key,
  }) : isRail = true;

  const DisappearingSearchButton.bottom({
    required this.animation,
    super.key,
  }) : isRail = false;

  @override
  State<DisappearingSearchButton> createState() =>
      _DisappearingSearchButtonState();
}

class _DisappearingSearchButtonState extends State<DisappearingSearchButton> {
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleAnimation = ScaleAnimation(parent: widget.animation);
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _scaleAnimation,
    child: FloatingActionButton(
      heroTag: null,
      onPressed: () => _onTap(context),
      child: const Icon(Icons.search),
      tooltip: 'Поиск',
      elevation: widget.isRail ? 0 : null,
    ),
  );

  void _onTap(BuildContext context) {
    final wm = SearchScope.animeSearchWMOf(
      context,
      listen: false,
    );
    return wm.open();
  }
}
