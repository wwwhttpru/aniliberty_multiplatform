import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_reset_password_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ResetPasswordStateConsumer extends StatelessWidget {
  final StateWidgetListener<ResetPasswordState> listener;
  final StateWidgetBuilder<ResetPasswordState> builder;
  final StateListenerCondition<ResetPasswordState>? listenWhen;
  final StateBuilderCondition<ResetPasswordState>? buildWhen;
  final Widget? child;

  const ResetPasswordStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ResetPasswordState>(
    stateReadable: AuthResetPasswordScope.resetPasswordSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ResetPasswordStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ResetPasswordState> builder;
  final StateBuilderCondition<ResetPasswordState>? buildWhen;
  final Widget? child;

  const ResetPasswordStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ResetPasswordState>(
    stateReadable: AuthResetPasswordScope.resetPasswordSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ResetPasswordStateListener extends StatelessWidget {
  final StateWidgetListener<ResetPasswordState> listener;
  final StateListenerCondition<ResetPasswordState>? listenWhen;
  final Widget child;

  const ResetPasswordStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ResetPasswordState>(
    stateReadable: AuthResetPasswordScope.resetPasswordSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ResetPasswordStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ResetPasswordState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ResetPasswordStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ResetPasswordState, T>(
    stateReadable: AuthResetPasswordScope.resetPasswordSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
