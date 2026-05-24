import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/scope/auth_forget_password_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget_model/forget_password_wm.dart';
import 'package:flutter/material.dart';

/// Text field for email
class ForgetPasswordTextField extends StatefulWidget {
  const ForgetPasswordTextField({super.key});

  @override
  State<ForgetPasswordTextField> createState() =>
      _ForgetPasswordTextFieldState();
}

class _ForgetPasswordTextFieldState extends State<ForgetPasswordTextField> {
  late final IForgetPasswordWM _forgetPasswordWM;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _forgetPasswordWM = AuthForgetPasswordScope.forgetPasswordWMOf(
      context,
      listen: false,
    );
    _emailController = TextEditingController(text: _forgetPasswordWM.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _emailController,
    decoration: InputDecoration(
      labelText: 'Email',
      prefixIcon: const Icon(Icons.email_outlined),
      border: context.resolver.inputBorder,
    ),
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.emailAddress,
    autofillHints: const [AutofillHints.email],
    onChanged: _forgetPasswordWM.setEmail,
    onSubmitted: (_) => _onDone(),
  );

  void _onDone() => _forgetPasswordWM.requestPasswordReset();
}
