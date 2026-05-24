import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/common/auth_scroll_layout.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/login_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/login/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:flutter/material.dart';

/// Login screen for authentication
class AuthLoginScreen extends StatelessWidget {
  const AuthLoginScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      forceMaterialTransparency: true,
      leading: CloseButton(onPressed: () => _onClose(context)),
    ),
    body: const AuthScrollLayout(child: _LoginForm()),
  );

  void _onClose(BuildContext context) {
    final wm = AuthLoginScope.loginWMOf(
      context,
      listen: false,
    );
    return wm.close();
  }
}

/// Login form widget
class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) => LoginStateListener(
    listener: (context, state) => state.mapOrNull(
      error: (_) => _onError(context),
    ),
    child: const Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        LoginHeader(),
        SizedBox(height: 32),
        LoginTextFields(),
        SizedBox(height: 8),
        ForgotPasswordButton(),
        SizedBox(height: 24),
        SignInButton(),
        SizedBox(height: 8),
        SignUpPrompt(),
      ],
    ),
  );

  void _onError(BuildContext context) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(
        'Не удается авторизоваться. '
        'Пожалуйста, проверьте правильность логина и пароля',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onErrorContainer,
        ),
      ),
      backgroundColor: theme.colorScheme.errorContainer,
      behavior: SnackBarBehavior.floating,
      shape: context.resolver.snackBarShape,
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
