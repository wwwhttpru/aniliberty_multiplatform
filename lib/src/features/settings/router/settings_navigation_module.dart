import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/router/settings_route.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/widget.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template settings_navigation_module}
/// Navigation module for settings feature.
/// {@endtemplate}
///
/// Registers routes for settings screens.
class SettingsNavigationModule implements NavigationModule {
  /// {@macro settings_route}
  final SettingsRoute _route;

  @override
  String get name => 'settings';

  @override
  Iterable<RouteDeclaration> get declarations => [
    RouteBuilderDeclaration(
      route: _route.generalSettings,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const SettingsScope(
          child: GeneralSettingsScreen(),
        ),
      ),
    ),
    RouteBuilderDeclaration(
      route: _route.videoSettings,
      routeBuilder: RouteBuilder.widget(
        builder: (context, routeNode) => const SettingsScope(
          child: VideoSettingsScreen(),
        ),
      ),
    ),
  ];

  @override
  Iterable<RouteNodeGuard> get guards => [];

  const SettingsNavigationModule({
    required this._route,
  });
}
