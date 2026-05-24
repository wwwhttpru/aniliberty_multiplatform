import 'package:flutter/material.dart';

/// {@template no_animation_page_transitions_builder}
/// A page transition builder that does not animate the page transition.
/// {@endtemplate}
class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates a [NoAnimationPageTransitionsBuilder].
  const NoAnimationPageTransitionsBuilder();

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}
