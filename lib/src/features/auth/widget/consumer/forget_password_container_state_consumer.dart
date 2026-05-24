import 'package:aniliberty_multiplatform/src/features/auth/di/auth_forget_password_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:yx_state_flutter/yx_state_flutter.dart';

class ForgetPasswordContainerStateBuilder extends StatelessWidget {
  final ForgetPasswordContainerSM forgetPasswordContainerSM;
  final Widget Function(
    BuildContext context,
    AuthForgetPasswordContainerOutputScope scope,
  )
  scope;
  final Widget Function(BuildContext context) noScope;

  const ForgetPasswordContainerStateBuilder({
    required this.forgetPasswordContainerSM,
    required this.scope,
    required this.noScope,
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      StateBuilder<ForgetPasswordContainerState>(
        stateReadable: forgetPasswordContainerSM,
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
          final AuthForgetPasswordContainerOutputScope value => scope(
            context,
            value,
          ),
          null => noScope(context),
        },
      );
}
