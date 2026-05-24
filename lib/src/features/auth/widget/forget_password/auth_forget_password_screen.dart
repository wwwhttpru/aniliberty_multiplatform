import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/common/auth_scroll_layout.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/forget_password_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/forget_password/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:flutter/material.dart';

/// Forget password screen for password recovery
class AuthForgetPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      forceMaterialTransparency: true,
      leading: CloseButton(onPressed: () => _onClose(context)),
    ),
    body: const AuthScrollLayout(child: _ForgetPasswordForm()),
  );

  void _onClose(BuildContext context) {
    final wm = AuthForgetPasswordScope.forgetPasswordWMOf(
      context,
      listen: false,
    );
    return wm.close();
  }
}

/// Forget password form widget
class _ForgetPasswordForm extends StatelessWidget {
  const _ForgetPasswordForm();

  @override
  Widget build(BuildContext context) => ForgetPasswordStateListener(
    listener: (context, state) => state.mapOrNull(
      success: (_) => _onSuccess(context),
      error: (_) => _onError(context),
    ),
    child: const Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        ForgetPasswordHeader(),
        SizedBox(height: 32),
        ForgetPasswordTextField(),
        SizedBox(height: 24),
        RequestPasswordResetButton(),
        SizedBox(height: 8),
        HaveTokenButton(),
      ],
    ),
  );

  void _onSuccess(BuildContext context) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(
        'Письмо отправлено',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      backgroundColor: theme.colorScheme.primaryContainer,
      behavior: SnackBarBehavior.floating,
      shape: context.resolver.snackBarShape,
      margin: const EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _onError(BuildContext context) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(
        'Не удалось отправить письмо. '
        'Пожалуйста, проверьте правильность email',
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
