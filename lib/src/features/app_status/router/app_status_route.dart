import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Route configuration for app status screens.
///
/// Provides route definitions and utilities for navigating to app status screens.
@immutable
class AppStatusRoute {
  /// App status screen ID
  YxRoute get appStatus => const YxRoute(id: 'app-status');

  const AppStatusRoute();
}
