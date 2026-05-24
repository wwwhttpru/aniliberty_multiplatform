import 'package:aniliberty_multiplatform/src/core/navigation/host/host_navigation_module.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

@immutable
class AppNavigationModule extends HostNavigationModule {
  @override
  Iterable<RouteDeclaration> get declarations => [];

  @override
  Iterable<RouteNodeGuard> get guards => const [];

  @override
  String get name => 'app';

  const AppNavigationModule();
}
