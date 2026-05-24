import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template catalog_route}
/// Route configuration for catalog screens.
///
/// Provides route definitions and utilities for navigating to catalog screens.
/// {@endtemplate}
@immutable
class CatalogRoute {
  /// {@macro catalog_route}
  /// Catalog tab screen ID
  final YxRoute catalogTab;

  /// Catalog release screen ID
  YxRoute get catalogRelease => const YxRoute(id: 'catalog-release');

  /// Catalog filter screen ID
  YxRoute get catalogFilter => const YxRoute(id: 'catalog-filter');

  /// {@macro catalog_route}
  const CatalogRoute({required this.catalogTab});
}
