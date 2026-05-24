import 'package:aniliberty_multiplatform/src/features/app_status/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/widget_model/app_status_wm.dart';
import 'package:flutter/material.dart';

/// Scope widget for app status feature.
///
/// Provides access to app status dependencies through the widget tree.
class AppStatusScope extends StatelessWidget {
  /// Child widget to be wrapped with the scope
  final Widget child;

  /// App status container output scope
  final AppStatusContainerOutputScope container;

  /// Creates a new instance of [AppStatusScope].
  ///
  /// [child] - The child widget to be wrapped with the scope
  const AppStatusScope({
    required this.child,
    required this.container,
    super.key,
  });

  static AppStatusContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = _AppStatusInheritedWidget.of(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'AppStatusContainerOutputScope',
    );
  }

  static AppStatusSM appStatusSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).appStatusSM;

  static IAppStatusWM appStatusWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).appStatusWM;

  @override
  Widget build(BuildContext context) => _AppStatusInheritedWidget(
    container: container,
    child: child,
  );
}

class _AppStatusInheritedWidget extends InheritedWidget {
  final AppStatusContainerOutputScope container;

  const _AppStatusInheritedWidget({
    required this.container,
    required super.child,
  });

  static AppStatusContainerOutputScope? of(
    BuildContext context, {
    bool listen = true,
  }) {
    _AppStatusInheritedWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<_AppStatusInheritedWidget>();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_AppStatusInheritedWidget>();
    }

    return widget?.container;
  }

  @override
  bool updateShouldNotify(_AppStatusInheritedWidget oldWidget) =>
      !identical(container, oldWidget.container);
}
