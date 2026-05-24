import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_login_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/login_wm.dart';
import 'package:flutter/material.dart';

/// Text fields for login and password
class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  late final ILoginWM _loginWM;
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _obscurePasswordNotifier;

  @override
  void initState() {
    super.initState();
    _loginWM = AuthLoginScope.loginWMOf(
      context,
      listen: false,
    );
    _loginController = TextEditingController(text: _loginWM.login);
    _passwordController = TextEditingController(text: _loginWM.password);
    _obscurePasswordNotifier = ValueNotifier(true);
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: _loginController,
        decoration: InputDecoration(
          labelText: 'Логин',
          prefixIcon: const Icon(Icons.person_outline),
          border: context.resolver.inputBorder,
        ),
        textInputAction: TextInputAction.next,
        autofillHints: const [AutofillHints.username],
        onChanged: _loginWM.setLogin,
      ),
      const SizedBox(height: 16),
      ValueListenableBuilder(
        valueListenable: _obscurePasswordNotifier,
        builder: (context, value, child) {
          return TextField(
            controller: _passwordController,
            obscureText: _obscurePasswordNotifier.value,
            decoration: InputDecoration(
              labelText: 'Пароль',
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
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onChanged: _loginWM.setPassword,
            onSubmitted: (_) => _onDone,
          );
        },
      ),
    ],
  );

  void _toggleObscurePassword() {
    final value = _obscurePasswordNotifier.value;
    _obscurePasswordNotifier.value = !value;
  }

  void _onDone() => _loginWM.signIn();
}
