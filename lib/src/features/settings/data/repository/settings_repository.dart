import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:meta/meta.dart';

/// {@macro settings_repository}
@immutable
final class SettingsRepository implements ISettingsRepository {
  /// Key-value database for theme mode
  final IKeyValueDB<String> _themeModeDB;

  /// Key-value database for language
  final IKeyValueDB<String> _languageDB;

  /// Key-value database for video quality
  final IKeyValueDB<String> _videoQualityDB;

  /// {@macro settings_repository}
  ///
  /// Creates a new instance of [SettingsRepository].
  ///
  /// [_themeModeDB] - The key-value database for theme mode storage.
  /// [_languageDB] - The key-value database for language storage.
  /// [_videoQualityDB] - The key-value database for video quality storage.
  const SettingsRepository({
    required this._themeModeDB,
    required this._languageDB,
    required this._videoQualityDB,
  });

  @override
  Future<AppThemeMode> readThemeMode() async {
    final value = await _themeModeDB.read();
    return AppThemeMode.values.firstWhere(
      (mode) => mode.code == value,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> writeThemeMode(
    AppThemeMode themeMode,
  ) => _themeModeDB.createOrUpdate(themeMode.code);

  @override
  Future<AppLanguage> readLanguage() async {
    final value = await _languageDB.read();
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == value,
      orElse: () => AppLanguage.ru,
    );
  }

  @override
  Future<void> writeLanguage(
    AppLanguage language,
  ) => _languageDB.createOrUpdate(language.code);

  @override
  Future<VideoQuality> readVideoQuality() async {
    final value = await _videoQualityDB.read();
    return VideoQuality.values.firstWhere(
      (quality) => quality.code == value,
      orElse: () => VideoQuality.hd,
    );
  }

  @override
  Future<void> writeVideoQuality(
    VideoQuality quality,
  ) => _videoQualityDB.createOrUpdate(quality.code);
}
