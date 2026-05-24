import 'package:aniliberty_multiplatform/src/features/catalog/router/catalog_route.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template i_catalog_navigation_interactor}
/// Interface for catalog navigation operations.
/// {@endtemplate}
abstract interface class ICatalogNavigationInteractor {
  /// Opens the filter page.
  ///
  /// Navigates to the catalog filter screen if it's not already open.
  void openFilter();

  /// Closes the filter page.
  ///
  /// Closes the catalog filter screen if it's currently open.
  void closeFilter();
}

/// {@macro i_catalog_navigation_interactor}
///
/// Implementation of [ICatalogNavigationInteractor] that handles navigation
/// to and from the catalog filter screen.
class CatalogNavigationInteractor implements ICatalogNavigationInteractor {
  /// {@macro yx_navigation_controller}
  final NavigationController _navigationController;

  /// {@macro catalog_route}
  final CatalogRoute _route;

  /// {@macro i_catalog_navigation_interactor}
  ///
  /// Creates a new instance of [CatalogNavigationInteractor].
  ///
  /// [_navigationController] - The navigation controller for route operations
  /// [_route] - The catalog route configuration
  const CatalogNavigationInteractor({
    required this._navigationController,
    required this._route,
  });

  @override
  void openFilter() {
    final route = _route.catalogFilter;

    final searchNode = _navigationController.state?.findByRoute(route);
    if (searchNode != null) {
      return;
    }

    _navigationController.push(route);
  }

  @override
  void closeFilter() {
    final route = _route.catalogFilter;

    final searchNode = _navigationController.state?.findByRoute(route);
    if (searchNode == null) {
      return;
    }

    _navigationController.pop();
  }
}
