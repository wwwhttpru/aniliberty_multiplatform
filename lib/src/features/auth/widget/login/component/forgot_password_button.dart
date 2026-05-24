import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/material.dart';

/// Button for password recovery
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) => LoginStateBuilder(
    builder: (context, state, _) => Align(
      alignment: .centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: context.resolver.buttonShape,
        ),
        onPressed: state.isIdle ? () => _onPressed(context) : null,
        child: const Text('Забыли пароль?'),
      ),
    ),
  );

  void _onPressed(BuildContext context) {
    final wm = AuthLoginScope.loginWMOf(
      context,
      listen: false,
    );
    return wm.forgotPassword();
  }
}
