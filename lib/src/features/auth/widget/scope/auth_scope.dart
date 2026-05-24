import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class AuthScope extends StatelessWidget {
  final Widget child;

  const AuthScope({
    required this.child,
    super.key,
  });

  static AuthContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<AuthContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(container, 'AuthContainerOutputScope');
  }

  static ProfileContainerHolder profileContainerHolderOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).profileContainerHolder;

  static AuthSM authSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).authSM;

  @override
  Widget build(BuildContext context) => ScopeProvider<AuthContainerOutputScope>(
    holder: AppScope.containerOf(context).authContainerHolder,
    child: ScopeBuilder<AuthContainerOutputScope>.withPlaceholder(
      placeholder: const ProgressLayout(),
      builder: (context, scope) => child,
    ),
  );
}
