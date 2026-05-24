import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_container.dart';
import 'package:aniliberty_multiplatform/src/core/navigation/host/host_navigation_module.dart';
import 'package:aniliberty_multiplatform/src/core/navigation/host/host_route_node_guard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show RouterConfig;
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template navigation_container_input_scope}
/// Input scope for navigation container
/// {@endtemplate}
@immutable
final class NavigationContainerInputScope {
  /// Root route
  final YxRoute rootRoute;

  /// Host navigation module
  final HostNavigationModule hostNavigationModule;

  /// {@macro navigation_container_input_scope}
  const NavigationContainerInputScope({
    required this.rootRoute,
    required this.hostNavigationModule,
  });
}

/// {@template navigation_container_output_scope}
/// Output scope for navigation container
/// {@endtemplate}
abstract interface class NavigationContainerOutputScope {
  /// Main navigation container.
  ///
  /// Provides the ability to obtain the main navigation controller,
  /// register new modules, or create a controller for a new module.
  ModuleNavigationContainer get moduleNavigationContainer;

  /// Main navigation configuration.
  ///
  /// Provides the ability to obtain the main navigation configuration.
  RouterConfig<Object> get routerConfig;
}

/// {@template navigation_container_scope}
/// Container for navigation container
/// {@endtemplate}
class NavigationContainerScope
    extends DataScopeContainer<NavigationContainerInputScope>
    implements NavigationContainerOutputScope {
  late final _debugObserver = dep<DebugObserverReadableImpl>(
    DebugObserverReadableImpl.new,
  );

  late final _guardSync = rawAsyncDep<GuardSync>(
    GuardSync.new,
    init: (dep) => Future.value(),
    dispose: (dep) => dep.close(),
  );

  late final _routeNodeGuard = dep<HostRouteNodeGuard>(
    () => HostRouteNodeGuardConfiguration(
      redirectGuard: const RedirectRouteNodeGuard(),
      observer: _debugObserver.get,
    ),
  );

  late final _stateManager = rawAsyncDep<RouteNodeStateManager>(
    () => RouteNodeStateManager(
      routeNode: data.rootRoute.toNode(),
      routeNodeGuard: _routeNodeGuard.get,
      guardSync: _guardSync.get,
      observer: _debugObserver.get,
    ),
    init: (dep) async => Future.value(),
    dispose: (dep) async => dep.close(),
  );

  late final _debugPanelModeNotifier = dep<DebugPanelModeNotifier>(
    () => DebugPanelModeNotifier(enableDebugPanel: kDebugMode),
  );

  late final _hostNavigationContainer = rawAsyncDep<HostNavigationContainer>(
    () => HostNavigationContainer(
      hostModule: data.hostNavigationModule,
      guardSync: _guardSync.get,
      stateManager: _stateManager.get,
      routeNodeGuard: _routeNodeGuard.get,
      debugPanelModeNotifier: _debugPanelModeNotifier.get,
    ),
    init: (dep) async => dep.initialize(),
    dispose: (dep) async => dep.dispose(),
  );

  @override
  ModuleNavigationContainer get moduleNavigationContainer =>
      _hostNavigationContainer.get;

  @override
  RouterConfig<Object> get routerConfig =>
      _hostNavigationContainer.get.routerConfig;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_guardSync},
    {_stateManager},
    {_hostNavigationContainer},
  ];

  NavigationContainerScope({required super.data});
}

/// {@template navigation_container_holder}
/// Holder for navigation container
/// {@endtemplate}
class NavigationContainerHolder
    extends
        BaseDataScopeHolder<
          NavigationContainerOutputScope,
          NavigationContainerScope,
          NavigationContainerInputScope
        > {
  NavigationContainerHolder();

  @override
  NavigationContainerScope createContainer(
    NavigationContainerInputScope data,
  ) => NavigationContainerScope(data: data);
}
