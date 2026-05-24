import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/forget_password_container_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/forget_password_wm.dart';
import 'package:flutter/material.dart';

/// {@template auth_forget_password_scope}
/// Scope widget for forget password screen
/// {@endtemplate}
class AuthForgetPasswordScope extends StatelessWidget {
  final ForgetPasswordContainerSM forgetPasswordContainerSM;
  final Widget child;

  /// {@macro auth_forget_password_scope}
  const AuthForgetPasswordScope({
    required this.forgetPasswordContainerSM,
    required this.child,
    super.key,
  });

  static AuthForgetPasswordContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = _AuthForgetPasswordInheritedWidget.of(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(
      container,
      'AuthForgetPasswordContainerOutputScope',
    );
  }

  static ForgetPasswordFormSM forgetPasswordFormSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).forgetPasswordFormSM;

  static ForgetPasswordSM forgetPasswordSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).forgetPasswordSM;

  static IForgetPasswordWM forgetPasswordWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).forgetPasswordWM;

  @override
  Widget build(BuildContext context) => ForgetPasswordContainerStateBuilder(
    forgetPasswordContainerSM: forgetPasswordContainerSM,
    scope: (context, scope) => _AuthForgetPasswordInheritedWidget(
      container: scope,
      child: child,
    ),
    noScope: (context) => const ProgressLayout(),
  );
}

class _AuthForgetPasswordInheritedWidget extends InheritedWidget {
  final AuthForgetPasswordContainerOutputScope container;

  const _AuthForgetPasswordInheritedWidget({
    required this.container,
    required super.child,
  });

  static AuthForgetPasswordContainerOutputScope? of(
    BuildContext context, {
    bool listen = true,
  }) {
    _AuthForgetPasswordInheritedWidget? widget;

    if (listen) {
      widget = context
          .dependOnInheritedWidgetOfExactType<
            _AuthForgetPasswordInheritedWidget
          >();
    } else {
      widget = context
          .getInheritedWidgetOfExactType<_AuthForgetPasswordInheritedWidget>();
    }

    return widget?.container;
  }

  @override
  bool updateShouldNotify(_AuthForgetPasswordInheritedWidget oldWidget) =>
      !identical(container, oldWidget.container);
}
