import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_form_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/material.dart';

/// Sign in button
class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) => LoginFormStateBuilder(
    builder: (context, formState, _) => LoginStateBuilder(
      builder: (context, loginState, _) {
        final isEnabled = formState.isValid && loginState.isIdle;
        return FilledButton(
          style: FilledButton.styleFrom(
            shape: context.resolver.buttonShape,
          ),
          onPressed: isEnabled ? () => _onPressed(context) : null,
          child: const Text('Войти'),
        );
      },
    ),
  );

  void _onPressed(BuildContext context) {
    final wm = AuthLoginScope.loginWMOf(
      context,
      listen: false,
    );
    return wm.signIn();
  }
}
