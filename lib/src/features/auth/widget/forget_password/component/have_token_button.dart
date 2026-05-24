import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/forget_password_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:flutter/material.dart';

/// Button for opening reset password screen
class HaveTokenButton extends StatelessWidget {
  const HaveTokenButton({super.key});

  @override
  Widget build(BuildContext context) => ForgetPasswordStateBuilder(
    builder: (context, state, _) => Align(
      child: TextButton(
        style: TextButton.styleFrom(
          shape: context.resolver.buttonShape,
        ),
        onPressed: state.isIdle ? () => _onPressed(context) : null,
        child: const Text('У меня уже есть токен'),
      ),
    ),
  );

  void _onPressed(BuildContext context) {
    final wm = AuthForgetPasswordScope.forgetPasswordWMOf(
      context,
      listen: false,
    );
    return wm.openResetPassword();
  }
}
