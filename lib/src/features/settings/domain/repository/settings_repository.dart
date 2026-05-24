import 'package:aniliberty_multiplatform/src/features/settings/domain/entity/app_language.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/entity/theme_mode.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';

/// {@template settings_repository}
/// Repository interface for app settings.
///
/// Provides methods to read and write app settings including theme mode,
/// language, and video quality preferences.
/// {@endtemplate}
abstract interface class ISettingsRepository {
  /// Reads the current theme mode from storage.
  ///
  /// Returns a [Future] that completes with the [AppThemeMode] that was
  /// previously selected by the user, or [AppThemeMode.system] if not set.
  Future<AppThemeMode> readThemeMode();

  /// Writes the theme mode to storage.
  ///
  /// [themeMode] - The theme mode to save
  Future<void> writeThemeMode(AppThemeMode themeMode);

  /// Reads the current language from storage.
  ///
  /// Returns a [Future] that completes with the [AppLanguage] that was
  /// previously selected by the user, or [AppLanguage.ru] if not set.
  Future<AppLanguage> readLanguage();

  /// Writes the language to storage.
  ///
  /// [language] - The language to save
  Future<void> writeLanguage(AppLanguage language);

  /// Reads the current video quality from storage.
  ///
  /// Returns a [Future] that completes with the [VideoQuality] that was
  /// previously selected by the user, or [VideoQuality.hd] if not set.
  Future<VideoQuality> readVideoQuality();

  /// Writes the video quality to storage.
  ///
  /// [quality] - The video quality to save
  Future<void> writeVideoQuality(VideoQuality quality);
}
