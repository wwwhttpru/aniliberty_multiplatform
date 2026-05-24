import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template franchises_route}
/// Route configuration for franchises screens.
///
/// Provides route IDs and argument keys for list and detail screens.
/// {@endtemplate}
@immutable
class FranchisesRoute {
  /// List of all franchises screen.
  YxRoute get franchises => const YxRoute(id: 'franchises');

  /// Single franchise detail screen.
  YxRoute get franchise => const YxRoute(id: 'franchise');

  /// Argument key for franchise ID when opening [franchise].
  String get franchiseId => 'franchise_id';

  /// Get franchise ID from route arguments.
  String? getFranchiseIDFromMap(Map<String, String> value) {
    final franchiseId = value[this.franchiseId];
    return franchiseId;
  }

  /// Constructor for [FranchisesRoute].
  ///
  /// {@macro franchises_route}
  const FranchisesRoute();
}
