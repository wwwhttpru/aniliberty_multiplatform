import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_reset_password_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/reset_password_wm.dart';
import 'package:flutter/material.dart';

/// Text fields for token, password and password confirmation
class ResetPasswordTextFields extends StatefulWidget {
  const ResetPasswordTextFields({super.key});

  @override
  State<ResetPasswordTextFields> createState() =>
      _ResetPasswordTextFieldsState();
}

class _ResetPasswordTextFieldsState extends State<ResetPasswordTextFields> {
  late final IResetPasswordWM _resetPasswordWM;
  late final TextEditingController _tokenController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmationController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;
  late final ValueNotifier<bool> _obscurePasswordConfirmationNotifier;

  @override
  void initState() {
    super.initState();
    _resetPasswordWM = AuthResetPasswordScope.resetPasswordWMOf(
      context,
      listen: false,
    );
    _tokenController = TextEditingController(text: _resetPasswordWM.token);
    _passwordController = TextEditingController(
      text: _resetPasswordWM.password,
    );
    _passwordConfirmationController = TextEditingController(
      text: _resetPasswordWM.passwordConfirmation,
    );
    _obscurePasswordNotifier = ValueNotifier(true);
    _obscurePasswordConfirmationNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: _tokenController,
        decoration: InputDecoration(
          labelText: 'Токен',
          prefixIcon: const Icon(Icons.key_outlined),
          border: context.resolver.inputBorder,
        ),
        textInputAction: TextInputAction.next,
        onChanged: _resetPasswordWM.setToken,
      ),
      const SizedBox(height: 16),
      ValueListenableBuilder(
        valueListenable: _obscurePasswordNotifier,
        builder: (context, value, child) {
          return TextField(
            controller: _passwordController,
            obscureText: _obscurePasswordNotifier.value,
            decoration: InputDecoration(
              labelText: 'Новый пароль',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePasswordNotifier.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: _toggleObscurePassword,
              ),
              border: context.resolver.inputBorder,
            ),
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: _resetPasswordWM.setPassword,
          );
        },
      ),
      const SizedBox(height: 16),
      ValueListenableBuilder(
        valueListenable: _obscurePasswordConfirmationNotifier,
        builder: (context, value, child) {
          return TextField(
            controller: _passwordConfirmationController,
            obscureText: _obscurePasswordConfirmationNotifier.value,
            decoration: InputDecoration(
              labelText: 'Подтверждение пароля',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePasswordConfirmationNotifier.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: _toggleObscurePasswordConfirmation,
              ),
              border: context.resolver.inputBorder,
            ),
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: _resetPasswordWM.setPasswordConfirmation,
            onSubmitted: (_) => _onDone(),
          );
        },
      ),
    ],
  );

  void _toggleObscurePassword() {
    final value = _obscurePasswordNotifier.value;
    _obscurePasswordNotifier.value = !value;
  }

  void _toggleObscurePasswordConfirmation() {
    final value = _obscurePasswordConfirmationNotifier.value;
    _obscurePasswordConfirmationNotifier.value = !value;
  }

  void _onDone() => _resetPasswordWM.resetPassword();
}
