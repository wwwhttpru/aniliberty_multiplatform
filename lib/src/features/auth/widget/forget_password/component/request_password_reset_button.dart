import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/forget_password_form_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/forget_password_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:flutter/material.dart';

/// Request password reset button
class RequestPasswordResetButton extends StatelessWidget {
  const RequestPasswordResetButton({super.key});

  @override
  Widget build(BuildContext context) => ForgetPasswordFormStateBuilder(
    builder: (context, formState, _) => ForgetPasswordStateBuilder(
      builder: (context, forgetPasswordState, _) {
        final isEnabled = formState.isValid && forgetPasswordState.isIdle;
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: context.resolver.buttonShape,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
          child: const Text('Отправить'),
        );
      },
    ),
  );

  void _onPressed(BuildContext context) {
    final wm = AuthForgetPasswordScope.forgetPasswordWMOf(
      context,
      listen: false,
    );
    return wm.requestPasswordReset();
  }
}
