import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_reset_password_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ResetPasswordFormStateConsumer extends StatelessWidget {
  final StateWidgetListener<ResetPasswordFormState> listener;
  final StateWidgetBuilder<ResetPasswordFormState> builder;
  final StateListenerCondition<ResetPasswordFormState>? listenWhen;
  final StateBuilderCondition<ResetPasswordFormState>? buildWhen;
  final Widget? child;

  const ResetPasswordFormStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ResetPasswordFormState>(
    stateReadable: AuthResetPasswordScope.resetPasswordFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ResetPasswordFormStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ResetPasswordFormState> builder;
  final StateBuilderCondition<ResetPasswordFormState>? buildWhen;
  final Widget? child;

  const ResetPasswordFormStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ResetPasswordFormState>(
    stateReadable: AuthResetPasswordScope.resetPasswordFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ResetPasswordFormStateListener extends StatelessWidget {
  final StateWidgetListener<ResetPasswordFormState> listener;
  final StateListenerCondition<ResetPasswordFormState>? listenWhen;
  final Widget child;

  const ResetPasswordFormStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ResetPasswordFormState>(
    stateReadable: AuthResetPasswordScope.resetPasswordFormSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ResetPasswordFormStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ResetPasswordFormState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ResetPasswordFormStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateSelector<ResetPasswordFormState, T>(
        stateReadable: AuthResetPasswordScope.resetPasswordFormSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
