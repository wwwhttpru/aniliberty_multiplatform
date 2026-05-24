import 'package:flutter/material.dart';

// copy from https://stackoverflow.com/questions/75690299/how-do-i-show-a-dialog-in-flutter-using-a-go-router-route
// сделать потом нормально
class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    final themes = InheritedTheme.capture(
      from: context,
      to: Navigator.of(context, rootNavigator: true).context,
    );

    return DialogRoute<T>(
      context: context,
      builder: builder,
      barrierColor: barrierColor,
      themes: themes,
      settings: this,
      anchorPoint: anchorPoint,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
    );
  }
}
