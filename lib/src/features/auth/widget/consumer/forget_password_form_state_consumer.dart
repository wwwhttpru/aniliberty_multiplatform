import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ForgetPasswordFormStateConsumer extends StatelessWidget {
  final StateWidgetListener<ForgetPasswordFormState> listener;
  final StateWidgetBuilder<ForgetPasswordFormState> builder;
  final StateListenerCondition<ForgetPasswordFormState>? listenWhen;
  final StateBuilderCondition<ForgetPasswordFormState>? buildWhen;
  final Widget? child;

  const ForgetPasswordFormStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ForgetPasswordFormState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ForgetPasswordFormStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ForgetPasswordFormState> builder;
  final StateBuilderCondition<ForgetPasswordFormState>? buildWhen;
  final Widget? child;

  const ForgetPasswordFormStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ForgetPasswordFormState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class ForgetPasswordFormStateListener extends StatelessWidget {
  final StateWidgetListener<ForgetPasswordFormState> listener;
  final StateListenerCondition<ForgetPasswordFormState>? listenWhen;
  final Widget child;

  const ForgetPasswordFormStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<ForgetPasswordFormState>(
    stateReadable: AuthForgetPasswordScope.forgetPasswordFormSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class ForgetPasswordFormStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<ForgetPasswordFormState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const ForgetPasswordFormStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateSelector<ForgetPasswordFormState, T>(
        stateReadable: AuthForgetPasswordScope.forgetPasswordFormSMOf(context),
        selector: selector,
        builder: builder,
        child: child,
      );
}
