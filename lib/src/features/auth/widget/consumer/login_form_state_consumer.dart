import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class LoginFormStateConsumer extends StatelessWidget {
  final StateWidgetListener<LoginFormState> listener;
  final StateWidgetBuilder<LoginFormState> builder;
  final StateListenerCondition<LoginFormState>? listenWhen;
  final StateBuilderCondition<LoginFormState>? buildWhen;
  final Widget? child;

  const LoginFormStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<LoginFormState>(
    stateReadable: AuthLoginScope.loginFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class LoginFormStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<LoginFormState> builder;
  final StateBuilderCondition<LoginFormState>? buildWhen;
  final Widget? child;

  const LoginFormStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<LoginFormState>(
    stateReadable: AuthLoginScope.loginFormSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class LoginFormStateListener extends StatelessWidget {
  final StateWidgetListener<LoginFormState> listener;
  final StateListenerCondition<LoginFormState>? listenWhen;
  final Widget child;

  const LoginFormStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<LoginFormState>(
    stateReadable: AuthLoginScope.loginFormSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class LoginFormStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<LoginFormState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const LoginFormStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<LoginFormState, T>(
    stateReadable: AuthLoginScope.loginFormSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
