import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_container.dart';
import 'package:yx_navigation/yx_navigation.dart';

abstract interface class HostRouteNodeGuard implements RouteNodeGuard {
  const HostRouteNodeGuard();

  /// Attaches guards to the route node.
  void attach(String name, Iterable<RouteNodeGuard> values);

  /// Detaches guards from the route node.
  void detach(String name);
}

/// {@template host_route_node_guard_configuration}
/// Guard configuration for the host navigation module.
///
/// Extends [GuardConfiguration] with dynamic guard management functionality
/// from various navigation modules. Allows attaching and detaching guards
/// at runtime without recreating the configuration.
///
/// Used in [HostNavigationContainer] to manage guards from the host module
/// and connected navigation modules.
/// {@endtemplate}
class HostRouteNodeGuardConfiguration extends GuardConfiguration
    implements HostRouteNodeGuard {
  /// Storage for guards grouped by module names.
  final Map<String, Iterable<RouteNodeGuard>> _values = {};

  /// Cached result of combining all guards.
  Iterable<RouteNodeGuard>? _cachedGuards;

  /// {@macro host_route_node_guard_configuration}
  ///
  /// [guards] - Base guards passed to the parent [GuardConfiguration]
  /// [redirectGuard] - Optional guard for redirects
  /// [observer] - Observer for guard events
  HostRouteNodeGuardConfiguration({
    super.guards = const [],
    super.redirectGuard,
    super.observer,
  });

  @override
  Iterable<RouteNodeGuard> get guards {
    final cached = _cachedGuards;
    if (cached != null) {
      return cached;
    }

    final baseGuards = super.guards;
    if (_values.isEmpty) {
      return _cachedGuards = baseGuards;
    }

    final combinedGuards = <RouteNodeGuard>[
      ...baseGuards,
      for (final guards in _values.values) ...guards,
    ];

    return _cachedGuards = List<RouteNodeGuard>.unmodifiable(combinedGuards);
  }

  /// Attaches guards to the route node.
  ///
  /// Attaches guards from the module with the specified name to the common
  /// configuration. Guards will be combined with base guards on the next
  /// access to [guards].
  ///
  /// [name] - The name of the navigation module from which guards are attached
  /// [values] - An iterable collection of guards to attach
  ///
  /// Throws [StateError] if guards with this name are already attached.
  @override
  void attach(String name, Iterable<RouteNodeGuard> values) {
    if (_values.containsKey(name)) {
      throw StateError('Guards for "$name" are already attached');
    }
    _values[name] = values;
    _cachedGuards = null;
  }

  /// Detaches guards from the route node.
  ///
  /// Removes previously attached guards from the module with the specified name.
  /// Guards will be excluded from the common configuration on the next
  /// access to [guards].
  ///
  /// [name] - The name of the navigation module from which guards are detached
  ///
  /// Throws [StateError] if guards with this name were not attached.
  @override
  void detach(String name) {
    if (!_values.containsKey(name)) {
      throw StateError('Guards for "$name" were not attached');
    }
    _values.remove(name);
    _cachedGuards = null; // Cache invalidation
  }
}
