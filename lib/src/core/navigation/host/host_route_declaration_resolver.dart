import 'package:aniliberty_multiplatform/src/core/navigation/base/navigation_container.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_navigation_flutter/yx_navigation_flutter.dart';

/// {@template host_route_declaration_resolver}
/// Route declaration resolver for the host navigation module.
///
/// Extends [RouteDeclarationResolver] with dynamic declaration management
/// functionality from various navigation modules. Allows attaching and detaching
/// route declarations at runtime without recreating the resolver.
///
/// Used in [HostNavigationContainer] to manage route declarations from the host
/// module and connected navigation modules.
/// {@endtemplate}
class HostRouteDeclarationResolver implements RouteDeclarationResolver {
  /// Initial declarations from the host module.
  final Map<YxRoute, RouteDeclaration> _initialDeclarations;

  /// Storage for declarations grouped by module names.
  final Map<String, Map<YxRoute, RouteDeclaration>> _values = {};

  /// Cached result of combining all declarations.
  Map<YxRoute, RouteDeclaration>? _cachedDeclarations;

  /// {@macro host_route_declaration_resolver}
  ///
  /// [declarations] - Initial route declarations from the host module
  HostRouteDeclarationResolver({
    required Iterable<RouteDeclaration> declarations,
  }) : _initialDeclarations = _buildDeclarationsMap(
         <YxRoute, RouteDeclaration>{},
         declarations,
       );

  @mustCallSuper
  @override
  Map<YxRoute, RouteDeclaration> get declarations {
    final cached = _cachedDeclarations;

    if (cached != null) {
      return cached;
    }

    return _cachedDeclarations = _makeDeclarations();
  }

  @override
  RouteDeclaration? resolve(RouteNode routeNode) {
    final declaration = declarations[routeNode.route];
    return declaration;
  }

  /// Attaches route declarations to the resolver.
  ///
  /// Attaches route declarations from the module with the specified name.
  /// Declarations will be combined with initial declarations on the next
  /// access to [declarations].
  ///
  /// [name] - The name of the navigation module from which declarations are attached.
  /// [values] - An iterable collection of route declarations to attach
  ///
  /// Throws [StateError] if declarations with this name are already attached.
  void attach(String name, Iterable<RouteDeclaration> values) {
    if (_values.containsKey(name)) {
      throw StateError('Declarations for "$name" are already attached');
    }

    final declarations = _buildDeclarationsMap(
      <YxRoute, RouteDeclaration>{},
      values,
    );

    _values[name] = declarations;
    _cachedDeclarations = null; // Cache invalidation
  }

  /// Detaches route declarations from the resolver.
  ///
  /// Removes previously attached declarations from the module with the
  /// specified name. Declarations will be excluded from the combined
  /// declarations on the next access to [declarations].
  ///
  /// [name] - The name of the navigation module from which declarations are detached.
  ///
  /// Throws [StateError] if declarations with this name were not attached.
  void detach(String name) {
    if (!_values.containsKey(name)) {
      throw StateError('Declarations for "$name" were not attached');
    }

    _values.remove(name);
    _cachedDeclarations = null; // Cache invalidation
  }

  /// Combines initial declarations with all attached module declarations.
  ///
  /// Returns a new map containing all route declarations from the host module
  /// and all attached navigation modules.
  Map<YxRoute, RouteDeclaration> _makeDeclarations() {
    final current = Map<YxRoute, RouteDeclaration>.of(_initialDeclarations);
    for (final entry in _values.entries) {
      current.addAll(entry.value);
    }
    return current;
  }

  /// Builds a map of route declarations from an iterable.
  ///
  /// Recursively processes all declarations and their nested declarations,
  /// creating a flat map indexed by route.
  ///
  /// [map] - The map to populate with declarations
  /// [declarations] - The iterable of route declarations to process
  ///
  /// Returns the populated map containing all route declarations.
  static Map<YxRoute, RouteDeclaration> _buildDeclarationsMap(
    Map<YxRoute, RouteDeclaration> map,
    Iterable<RouteDeclaration> declarations,
  ) {
    for (final currentDeclaration in declarations) {
      assert(
        !map.containsKey(currentDeclaration.route),
        'Map does already contain route ${currentDeclaration.route}',
      );

      map[currentDeclaration.route] = currentDeclaration;
      map.addAll(_buildDeclarationsMap(map, currentDeclaration.declarations));
    }

    return map;
  }
}
