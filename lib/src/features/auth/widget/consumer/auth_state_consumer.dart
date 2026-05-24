import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class AuthStateConsumer extends StatelessWidget {
  final StateWidgetListener<AuthState> listener;
  final StateWidgetBuilder<AuthState> builder;
  final StateListenerCondition<AuthState>? listenWhen;
  final StateBuilderCondition<AuthState>? buildWhen;
  final Widget? child;

  const AuthStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<AuthState>(
    stateReadable: AuthScope.authSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class AuthStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<AuthState> builder;
  final StateBuilderCondition<AuthState>? buildWhen;
  final Widget? child;

  const AuthStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<AuthState>(
    stateReadable: AuthScope.authSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}

class AuthStateListener extends StatelessWidget {
  final StateWidgetListener<AuthState> listener;
  final StateListenerCondition<AuthState>? listenWhen;
  final Widget child;

  const AuthStateListener({
    required this.listener,
    required this.child,
    this.listenWhen,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateListener<AuthState>(
    stateReadable: AuthScope.authSMOf(context),
    listener: listener,
    listenWhen: listenWhen,
    child: child,
  );
}

class AuthStateSelector<T> extends StatelessWidget {
  final StateWidgetSelector<AuthState, T> selector;
  final StateWidgetBuilder<T> builder;
  final Widget? child;

  const AuthStateSelector({
    required this.selector,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateSelector<AuthState, T>(
    stateReadable: AuthScope.authSMOf(context),
    selector: selector,
    builder: builder,
    child: child,
  );
}
