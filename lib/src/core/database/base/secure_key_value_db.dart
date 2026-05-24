import 'package:aniliberty_multiplatform/src/core/database/base/key_value_db.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

/// {@template secure_key_value_db}
/// Base class for secure key value database implementation.
/// {@endtemplate}
abstract base class SecureKeyValueDB<T extends Object>
    implements IKeyValueDB<T> {
  /// Secure storage instance
  final FlutterSecureStorage _secureStorage;

  /// Key for the value
  final String _key;

  /// {@macro secure_key_value_db}
  const SecureKeyValueDB({
    required this._secureStorage,
    required this._key,
  });

  @mustCallSuper
  @override
  Future<void> delete() => _secureStorage.delete(key: _key);
}

/// {@template secure_string_key_value_db}
/// Secure string key value database implementation.
/// {@endtemplate}
final class SecureStringKeyValueDB extends SecureKeyValueDB<String> {
  /// {@macro secure_string_key_value_db}
  const SecureStringKeyValueDB({
    required super.secureStorage,
    required super.key,
  });

  @override
  Future<void> createOrUpdate(String value) => _secureStorage.write(
    key: _key,
    value: value,
  );

  @override
  Future<String?> read() => _secureStorage.read(key: _key);
}
