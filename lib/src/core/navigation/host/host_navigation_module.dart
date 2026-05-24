import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_module.dart';
import 'package:flutter/widgets.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template host_navigation_module}
/// Interface for the host navigation module.
///
/// The host navigation module is the primary module that provides core
/// navigation functionality. It differs from regular [NavigationModule]
/// instances in that it represents the main navigation entry point of
/// the application.
///
/// Only one host module should exist per navigation container, and it
/// cannot be unregistered once registered.
///
/// The host module can also provide configuration for [YxRouterDelegate]
/// through optional getters that will be used when creating the router delegate.
/// {@endtemplate}
abstract class HostNavigationModule implements NavigationModule {
  /// Optional navigator key for the router delegate.
  ///
  /// If not provided, a new [GlobalKey] will be created automatically.
  GlobalKey<NavigatorState>? get routerDelegateNavigatorKey => null;

  /// Optional transition delegate for route transitions.
  ///
  /// Controls how route transitions are animated.
  TransitionDelegate<Object?>? get routerDelegateTransitionDelegate => null;

  /// Optional list of navigator observers.
  ///
  /// Observers will receive notifications about route changes.
  List<NavigatorObserver> get routerDelegateObservers => const [];

  /// Optional restoration scope ID.
  ///
  /// Used for state restoration on supported platforms.
  String? get routerDelegateRestorationScopeId => null;

  /// Optional back button handler.
  ///
  /// Custom handler for back button behavior.
  BackButtonHandler? get routerDelegateBackButtonHandler => null;

  /// Optional default display type for the debug panel.
  DebugPanelDisplayType? get routerDelegateDefaultDisplayType => null;

  /// Optional observer readable for debug panel.
  ///
  /// Provides data for the debug panel observer.
  DebugObserverReadable? get routerDelegateObserverReadable => null;

  /// Optional custom builder for the navigator.
  ///
  /// Allows wrapping the navigator with custom widgets.
  NavigatorBuilder? get routerDelegateBuilder => null;

  const HostNavigationModule();
}
