import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_container.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template navigation_module}
/// Interface for a navigation module.
///
/// A navigation module represents a self-contained unit of navigation that
/// provides route declarations and guards. Modules can be registered with
/// a [ModuleNavigationContainer] to make their routes available in the
/// navigation system.
///
/// Each module must have a unique name and can provide:
/// - Route declarations that define available routes
/// - Guards that control access to routes
///
/// Modules are typically used to organize navigation by feature or domain,
/// allowing for better code organization and modular architecture.
/// {@endtemplate}
abstract interface class NavigationModule {
  /// The unique name of the navigation module.
  ///
  /// This name is used to identify the module when registering or unregistering
  /// it from the navigation container. Must be unique within a navigation container.
  String get name;

  /// Route declarations for this navigation module.
  ///
  /// These declarations define the routes that this module provides.
  /// The declarations can include nested route declarations for hierarchical
  /// route structures.
  Iterable<RouteDeclaration> get declarations;

  /// Guards for this navigation module.
  ///
  /// These guards are applied to all routes in this module when evaluating
  /// navigation permissions. Guards are executed in order before allowing
  /// navigation to proceed.
  Iterable<RouteNodeGuard> get guards;
}
