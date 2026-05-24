import 'package:aniliberty_multiplatform/src/core/database/base/key_value_db.dart';
import 'package:aniliberty_multiplatform/src/core/database/base/secure_key_value_db.dart';
import 'package:aniliberty_multiplatform/src/core/database/drift/app_drift_database.dart';
import 'package:aniliberty_multiplatform/src/core/database/drift/key_value_db/key_value_db.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template app_database}
/// Interface for the app database.
/// {@endtemplate}
abstract interface class IAppDatabase {
  /// Secure key value database for auth token
  abstract final IKeyValueDB<String> authToken;

  /// Key value database for theme mode
  abstract final IKeyValueDB<String> themeMode;

  /// Key value database for language
  abstract final IKeyValueDB<String> language;

  /// Key value database for video quality
  abstract final IKeyValueDB<String> videoQuality;
}

/// {@template app_database_impl}
/// Implementation of the app database.
/// {@endtemplate}
class AppDatabase implements IAppDatabase {
  /// Secure storage
  final FlutterSecureStorage _secureStorage;

  /// {@macro app_drift_database}
  final AppDriftDatabase _appDriftDatabase;

  /// Secure key value database for auth token
  @override
  late final IKeyValueDB<String> authToken = SecureStringKeyValueDB(
    secureStorage: _secureStorage,
    key: 'auth_token',
  );

  /// Key value database for theme mode
  @override
  late final IKeyValueDB<String> themeMode = DriftStringKeyValueDB(
    dao: _appDriftDatabase.keyValueDao,
    key: 'theme_mode',
  );

  /// Key value database for language
  @override
  late final IKeyValueDB<String> language = DriftStringKeyValueDB(
    dao: _appDriftDatabase.keyValueDao,
    key: 'language',
  );

  /// Key value database for video quality
  @override
  late final IKeyValueDB<String> videoQuality = DriftStringKeyValueDB(
    dao: _appDriftDatabase.keyValueDao,
    key: 'video_quality',
  );

  /// {@macro app_database}
  AppDatabase()
    : _secureStorage = const FlutterSecureStorage(),
      _appDriftDatabase = AppDriftDatabase.name(
        name: 'aniliberty_multiplatform',
      );

  /// Initialize the app database.
  Future<void> init() => Future<void>.value();

  /// Close the app database.
  Future<void> close() => _appDriftDatabase.close();
}
