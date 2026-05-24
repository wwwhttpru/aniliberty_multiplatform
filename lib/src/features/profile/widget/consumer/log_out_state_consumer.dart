import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/widget/scope/profile_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class LogOutStateConsumer extends StatelessWidget {
  final StateWidgetListener<LogOutState> listener;
  final StateWidgetBuilder<LogOutState> builder;
  final StateListenerCondition<LogOutState>? listenWhen;
  final StateBuilderCondition<LogOutState>? buildWhen;
  final Widget? child;

  const LogOutStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<LogOutState>(
    stateReadable: ProfileScope.logOutSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class LogOutStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<LogOutState> builder;
  final StateBuilderCondition<LogOutState>? buildWhen;
  final Widget? child;

  const LogOutStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<LogOutState>(
    stateReadable: ProfileScope.logOutSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}
