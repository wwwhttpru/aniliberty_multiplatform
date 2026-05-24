import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/widget_model/tab_bar_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class TabBarScope extends StatelessWidget {
  final Widget child;

  const TabBarScope({
    required this.child,
    super.key,
  });

  static TabBarContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<TabBarContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'TabBarContainerOutputScope',
    );
  }

  static TabBarSM tabBarSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).tabBarSM;

  static ITabBarWM tabBarWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).tabBarWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<TabBarContainerOutputScope>(
        holder: AppScope.containerOf(context).tabBarContainerHolder,
        child: ScopeBuilder<TabBarContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => child,
        ),
      );
}
