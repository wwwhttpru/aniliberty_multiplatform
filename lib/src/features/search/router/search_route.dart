import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template search_route}
/// Route configuration for search screens.
///
/// Provides route definitions and utilities for navigating to search screens.
/// {@endtemplate}
@immutable
class SearchRoute {
  /// Route for the search screen.
  ///
  /// Returns a [YxRoute] with id 'search' for navigating to the search screen.
  YxRoute get search => const YxRoute(id: 'search');

  /// {@macro search_route}
  const SearchRoute();
}
