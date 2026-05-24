import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/widget/scope/profile_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ProfileStateConsumer extends StatelessWidget {
  final StateWidgetListener<ProfileState> listener;
  final StateWidgetBuilder<ProfileState> builder;
  final StateListenerCondition<ProfileState>? listenWhen;
  final StateBuilderCondition<ProfileState>? buildWhen;
  final Widget? child;

  const ProfileStateConsumer({
    required this.listener,
    required this.builder,
    this.listenWhen,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateConsumer<ProfileState>(
    stateReadable: ProfileScope.profileSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
    listener: listener,
    listenWhen: listenWhen,
  );
}

class ProfileStateBuilder extends StatelessWidget {
  final StateWidgetBuilder<ProfileState> builder;
  final StateBuilderCondition<ProfileState>? buildWhen;
  final Widget? child;

  const ProfileStateBuilder({
    required this.builder,
    this.buildWhen,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<ProfileState>(
    stateReadable: ProfileScope.profileSMOf(context),
    builder: builder,
    buildWhen: buildWhen,
    child: child,
  );
}
