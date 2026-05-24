import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// Route configuration for settings screens.
///
/// Provides route definitions and utilities for navigating to settings screens.
@immutable
class SettingsRoute {
  /// General settings screen ID
  YxRoute get generalSettings => const YxRoute(id: 'general-settings');

  /// Video settings screen ID
  YxRoute get videoSettings => const YxRoute(id: 'video-settings');

  const SettingsRoute();
}
