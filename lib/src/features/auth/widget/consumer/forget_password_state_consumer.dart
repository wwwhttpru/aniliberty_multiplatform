import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ForgetPasswordStateConsumer extends StatelessWidget {
  final StateWidgetListener<ForgetPasswordState> listener;
  final StateWidgetBuilder<ForgetPasswordState> builder;
  final StateListenerCondition<ForgetPasswordState>? listenWhen;
  final StateBuilderCondition<ForgetPasswordState>? buildWhen;
  final Widget? child;

  const ForgetPasswordStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ForgetPasswordState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ForgetPasswordStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ForgetPasswordState> builder;
  final StateBuilderCondition<ForgetPasswordState>? buildWhen;
  final Widget? child;

  const ForgetPasswordStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ForgetPasswordState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ForgetPasswordStateListener extends StatelessWidget {
  final StateWidgetListener<ForgetPasswordState> listener;
  final StateListenerCondition<ForgetPasswordState>? listenWhen;
  final Widget child;

  const ForgetPasswordStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ForgetPasswordState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ForgetPasswordStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ForgetPasswordState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ForgetPasswordStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<ForgetPasswordState, T>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
