import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/common/auth_scroll_layout.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/consumer/reset_password_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/reset_password/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_reset_password_scope.dart';
import 'package:flutter/material.dart';

/// Reset password screen for password reset
class AuthResetPasswordScreen extends StatelessWidget {
  const AuthResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      forceMaterialTransparency: true,
      leading: CloseButton(onPressed: () => _onClose(context)),
    ),
    body: const AuthScrollLayout(child: _ResetPasswordForm()),
  );

  void _onClose(BuildContext context) {
    final wm = AuthResetPasswordScope.resetPasswordWMOf(
      context,
      listen: false,
    );
    return wm.close();
  }
}

/// Reset password form widget
class _ResetPasswordForm extends StatelessWidget {
  const _ResetPasswordForm();

  @override
  Widget build(BuildContext context) => ResetPasswordStateListener(
    listener: (context, state) => state.mapOrNull(
      success: (_) => _onSuccess(context),
      error: (_) => _onError(context),
    ),
    child: const Column(
      mainAxisAlignment: .center,
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        ResetPasswordHeader(),
        SizedBox(height: 32),
        ResetPasswordTextFields(),
        SizedBox(height: 24),
        ResetPasswordButton(),
      ],
    ),
  );

  void _onSuccess(BuildContext context) {
    final theme = Theme.of(context);
    final snackBar = SnackBar(
      content: Text(
        'Пароль успешно сброшен',
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
        'Не удалось сбросить пароль. '
        'Пожалуйста, проверьте правильность данных',
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
