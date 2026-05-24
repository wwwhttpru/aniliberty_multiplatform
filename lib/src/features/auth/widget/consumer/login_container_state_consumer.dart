import 'package:aniliberty_multiplatform/src/features/auth/di/auth_login_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class LoginContainerStateBuilder extends StatelessWidget {
  final LoginContainerSM loginContainerSM;
  final Widget Function(
    BuildContext context,
    AuthLoginContainerOutputScope scope,
  )
  scope;
  final Widget Function(BuildContext context) noScope;

  const LoginContainerStateBuilder({
    required this.loginContainerSM,
    required this.scope,
    required this.noScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StateBuilder<LoginContainerState>(
    stateReadable: loginContainerSM,
    buildWhen: (prev, next) {
      if (prev == null && next != null) {
        return true;
      }

      if (prev != null && next != null) {
        return prev != next;
      }

      return false;
    },
    builder: (context, state, _) => switch (state) {
      final AuthLoginContainerOutputScope value => scope(context, value),
      null => noScope(context),
    },
  );
}
