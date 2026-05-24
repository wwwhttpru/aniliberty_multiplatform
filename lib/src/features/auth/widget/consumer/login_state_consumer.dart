import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class LoginStateConsumer extends StatelessWidget {
  final StateWidgetListener<LoginState> listener;
  final StateWidgetBuilder<LoginState> builder;
  final StateListenerCondition<LoginState>? listenWhen;
  final StateBuilderCondition<LoginState>? buildWhen;
  final Widget? child;

  const LoginStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<LoginState>(
    stateReadable: AuthLoginScope.loginSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class LoginStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<LoginState> builder;
  final StateBuilderCondition<LoginState>? buildWhen;
  final Widget? child;

  const LoginStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<LoginState>(
    stateReadable: AuthLoginScope.loginSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class LoginStateListener extends StatelessWidget {
  final StateWidgetListener<LoginState> listener;
  final StateListenerCondition<LoginState>? listenWhen;
  final Widget child;

  const LoginStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<LoginState>(
    stateReadable: AuthLoginScope.loginSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class LoginStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<LoginState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const LoginStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<LoginState, T>(
    stateReadable: AuthLoginScope.loginSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
