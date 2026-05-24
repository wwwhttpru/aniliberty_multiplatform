import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_container_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/login_wm.dart';
import 'package:flutter/material.dart';

/// {@template auth_login_scope}
/// Scope widget for login screen
/// {@endtemplate}
class AuthLoginScope extends StatelessWidget {
  final LoginContainerSM loginContainerSM;
  final Widget child;

  /// {@macro auth_login_scope}
  const AuthLoginScope({
    required this.loginContainerSM,
    required this.child,
    super.key,
  });

  static AuthLoginContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = _AuthLoginInheritedWidget.of(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'AuthLoginContainerOutputScope',
    );
  }

  static LoginFormSM loginFormSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).loginFormSM;

  static LoginSM loginSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).loginSM;

  static ILoginWM loginWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).loginWM;

  @override
  Widget build(BuildContext context) => LoginContainerStateBuilder(
    loginContainerSM: loginContainerSM,
    scope: (context, scope) => _AuthLoginInheritedWidget(
      container: scope,
      child: child,
    ),
    noScope: (context) => const ProgressLayout(),
  );
}

class _AuthLoginInheritedWidget extends InheritedWidget {
  final AuthLoginContainerOutputScope container;

  const _AuthLoginInheritedWidget({
    required this.container,
    required super.child,
  });

  static AuthLoginContainerOutputScope? of(
    BuildContext context, {
    bool listen = true,
  }) {
    _AuthLoginInheritedWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<_AuthLoginInheritedWidget>();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_AuthLoginInheritedWidget>();
    }

    return widget?.container;
  }

  @override
  bool updateShouldNotify(_AuthLoginInheritedWidget oldWidget) =>
      !identical(container, oldWidget.container);
}
