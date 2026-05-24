import 'package:aniliberty_multiplatform/src/features/auth/di/auth_reset_password_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ResetPasswordContainerStateBuilder extends StatelessWidget {
  final ResetPasswordContainerSM resetPasswordContainerSM;
  final Widget Function(
    BuildContext context,
    AuthResetPasswordContainerOutputScope scope,
  )
  scope;
  final Widget Function(BuildContext context) noScope;

  const ResetPasswordContainerStateBuilder({
    required this.resetPasswordContainerSM,
    required this.scope,
    required this.noScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateBuilder<ResetPasswordContainerState>(
        stateReadable: resetPasswordContainerSM,
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
          final AuthResetPasswordContainerOutputScope value => scope(
            context,
            value,
          ),
          null => noScope(context),
        },
      );
}
