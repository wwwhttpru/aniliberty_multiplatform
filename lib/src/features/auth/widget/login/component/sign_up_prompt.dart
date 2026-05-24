import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/material.dart';

/// Prompt to sign up if user doesn't have an account
class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) => LoginStateBuilder(
    builder: (context, state, _) => TextButton(
      style: TextButton.styleFrom(
        shape: context.resolver.buttonShape,
      ),
      onPressed: state.isIdle ? () => _onSignUpPressed(context) : null,
      child: const Text('Регистрация'),
    ),
  );

  void _onSignUpPressed(BuildContext context) {
    final wm = AuthLoginScope.loginWMOf(
      context,
      listen: false,
    );
    return wm.signUp();
  }
}
