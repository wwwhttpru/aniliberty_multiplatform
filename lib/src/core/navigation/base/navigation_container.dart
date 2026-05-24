import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_module.dart';
import 'package:aniliberty_multiplatform/src/core/navigation/host/host_navigation_module.dart';
import 'package:aniliberty_multiplatform/src/core/navigation/host/host_route_declaration_resolver.dart';
import 'package:aniliberty_multiplatform/src/core/navigation/host/host_route_node_guard.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

part '../host/host_navigation_container.dart';

/// {@template navigation_container}
/// Base interface that provides navigation controller and guard synchronization
/// for features.
///
/// This interface is used by features to access navigation functionality
/// without directly depending on the host navigation implementation.
/// {@endtemplate}
abstract interface class NavigationContainer {
  /// The host or parent navigation controller.
  ///
  /// Provides methods to navigate between routes, get current route state,
  /// and manage navigation stack.
  NavigationController get navigationController;

  /// Guard synchronization service.
  ///
  /// Used to trigger guard re-evaluation when navigation state changes.
  GuardSync get guardSync;
}

/// {@template module_navigation_container}
/// Extended navigation container for module-based navigation architecture.
///
/// Provides functionality to dynamically register and unregister navigation
/// modules at runtime, allowing for modular navigation management.
///
/// Modules can provide their own route declarations and guards, which are
/// automatically integrated into the navigation system.
/// {@endtemplate}
abstract class ModuleNavigationContainer implements NavigationContainer {
  /// Registers a navigation module.
  ///
  /// Adds the module's route declarations and guards to the navigation system.
  /// The module becomes active and its routes become available for navigation.
  ///
  /// [navigationModule] - The navigation module to register
  ///
  /// Throws [StateError] if a module with the same name is already registered.
  void register(NavigationModule navigationModule);

  /// Unregisters a navigation module.
  ///
  /// Removes the module's route declarations and guards from the navigation
  /// system. The module's routes are no longer available for navigation.
  ///
  /// [navigationModule] - The navigation module to unregister
  ///
  /// Throws [StateError] if the module is not registered.
  void unregister(NavigationModule navigationModule);

  /// Creates a navigation controller for a specific route node resolver.
  ///
  /// This method allows creating specialized navigation controllers that
  /// use custom route node resolution logic while still using the shared
  /// navigation state manager.
  ///
  /// [nodeResolver] - The resolver for obtaining route nodes
  ///
  /// Returns a new [NavigationController] instance configured with the
  /// provided node resolver.
  @useResult
  NavigationController createNavigationController({
    required RouteNodeResolver nodeResolver,
  });
}
