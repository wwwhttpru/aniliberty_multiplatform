import 'package:aniliberty_multiplatform/src/core/config/config.dart';
import 'package:aniliberty_multiplatform/src/core/network/network.dart';
import 'package:aniliberty_multiplatform/src/core/widget/component/component.dart';
import 'package:aniliberty_multiplatform/src/features/app/di/di.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class AppScope extends StatelessWidget {
  final AppContainerHolder appContainerHolder;
  final Widget child;

  const AppScope({
    required this.appContainerHolder,
    required this.child,
    super.key,
  });

  static AppContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<AppContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(container, 'AppOutputScope');
  }

  static AppConfig configOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).appConfig;

  static NavigationContainerOutputScope navigationScopeOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).navigationScope;

  static AppNetwork networkOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).appNetwork;

  @override
  Widget build(BuildContext context) => ScopeProvider<AppContainerOutputScope>(
    holder: appContainerHolder,
    child: ScopeBuilder<AppContainerOutputScope>.withPlaceholder(
      holder: appContainerHolder,
      placeholder: const ProgressLayout(),
      builder: (context, scope) => child,
    ),
  );
}
