import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template release_route}
/// Route configuration for release screens.
///
/// Provides route definitions and utilities for navigating to release screens.
/// {@endtemplate}
@immutable
class ReleaseRoute {
  /// Release screen ID.
  YxRoute get release => const YxRoute(id: 'release');

  /// Release latest all screen ID.
  YxRoute get releaseLatestAll => const YxRoute(id: 'releases-latest-all');

  /// Release screen argument key.
  String get releaseAliasOrId => 'alias_or_id';

  /// Get alias or id from map.
  String? getAliasOrIDFromMap(Map<String, String> map) {
    final value = map[releaseAliasOrId];
    return value;
  }

  /// {@macro release_route}
  const ReleaseRoute();
}
