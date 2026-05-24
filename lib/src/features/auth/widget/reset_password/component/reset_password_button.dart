import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/reset_password_form_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/reset_password_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_reset_password_scope.dart';
import 'package:flutter/material.dart';

/// Reset password button
class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({super.key});

  @override
  Widget build(BuildContext context) => ResetPasswordFormStateBuilder(
    builder: (context, formState, _) => ResetPasswordStateBuilder(
      builder: (context, resetPasswordState, _) {
        final isEnabled = formState.isValid && resetPasswordState.isIdle;
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: context.resolver.buttonShape,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
          child: const Text('Сбросить пароль'),
        );
      },
    ),
  );

  void _onPressed(BuildContext context) {
    final wm = AuthResetPasswordScope.resetPasswordWMOf(
      context,
      listen: false,
    );
    return wm.resetPassword();
  }
}
