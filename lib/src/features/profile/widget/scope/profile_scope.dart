import 'package:aniliberty_multiplatform/src/features/auth/auth.dart';
import 'package:aniliberty_multiplatform/src/features/profile/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/widget/widget_model/profile_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class ProfileScope extends StatelessWidget {
  final Widget Function(BuildContext context) authenticated;
  final Widget Function(BuildContext context) unauthenticated;

  const ProfileScope({
    required this.authenticated,
    required this.unauthenticated,
    super.key,
  });

  static ProfileContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final scope = ScopeProvider.of<ProfileContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(scope, 'ProfileContainerOutputScope');
  }

  static ProfileSM profileSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).profileSM;

  static LogOutSM logOutSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).logOutSM;

  static IProfileWM profileWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).profileWM;

  @override
  Widget build(BuildContext context) => AuthStateBuilder(
    builder: (context, state, child) => state.maybeMap(
      orElse: () => unauthenticated(context),
      authenticated: (_) => child ?? authenticated(context),
    ),
    child: ScopeProvider<ProfileContainerOutputScope>(
      holder: AuthScope.profileContainerHolderOf(context),
      child: ScopeBuilder<ProfileContainerOutputScope>.withPlaceholder(
        placeholder: unauthenticated(context),
        builder: (context, scope) => authenticated(context),
      ),
    ),
  );
}
