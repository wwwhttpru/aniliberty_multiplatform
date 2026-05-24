import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/reset_password_container_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/reset_password_wm.dart';
import 'package:flutter/material.dart';

/// {@template auth_reset_password_scope}
/// Scope widget for reset password screen
/// {@endtemplate}
class AuthResetPasswordScope extends StatelessWidget {
  final ResetPasswordContainerSM resetPasswordContainerSM;
  final Widget child;

  /// {@macro auth_reset_password_scope}
  const AuthResetPasswordScope({
    required this.resetPasswordContainerSM,
    required this.child,
    super.key,
  });

  static AuthResetPasswordContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = _AuthResetPasswordInheritedWidget.of(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'AuthResetPasswordContainerOutputScope',
    );
  }

  static ResetPasswordFormSM resetPasswordFormSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).resetPasswordFormSM;

  static ResetPasswordSM resetPasswordSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).resetPasswordSM;

  static IResetPasswordWM resetPasswordWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).resetPasswordWM;

  @override
  Widget build(BuildContext context) => ResetPasswordContainerStateBuilder(
    resetPasswordContainerSM: resetPasswordContainerSM,
    scope: (context, scope) => _AuthResetPasswordInheritedWidget(
      container: scope,
      child: child,
    ),
    noScope: (context) => const ProgressLayout(),
  );
}

class _AuthResetPasswordInheritedWidget extends InheritedWidget {
  final AuthResetPasswordContainerOutputScope container;

  const _AuthResetPasswordInheritedWidget({
    required this.container,
    required super.child,
  });

  static AuthResetPasswordContainerOutputScope? of(
    BuildContext context, {
    bool listen = true,
  }) {
    _AuthResetPasswordInheritedWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<
            _AuthResetPasswordInheritedWidget
          >();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_AuthResetPasswordInheritedWidget>();
    }

    return widget?.container;
  }

  @override
  bool updateShouldNotify(_AuthResetPasswordInheritedWidget oldWidget) =>
      !identical(container, oldWidget.container);
}
