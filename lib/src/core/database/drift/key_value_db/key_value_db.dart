import 'package:aniliberty_multiplatform/src/core/database/base/key_value_db.dart';
import 'package:aniliberty_multiplatform/src/core/database/drift/key_value_db/key_value_dao.dart';

abstract class _DriftKeyValueDB<T extends Object> implements IKeyValueDB<T> {
  /// Key of the value
  final String _key;

  /// {@macro key_value_dao}
  final KeyValueDao _dao;

  const _DriftKeyValueDB({
    required this._dao,
    required this._key,
  });

  @override
  Future<void> delete() => _dao.deleteKeyValue(_key);

  @override
  Future<void> createOrUpdate(T value) => _dao.createOrUpdate(_key, value);
}

final class DriftStringKeyValueDB extends _DriftKeyValueDB<String> {
  DriftStringKeyValueDB({required super.dao, required super.key});

  @override
  Future<String?> read() => _dao.readString(_key);
}

final class DriftIntKeyValueDB extends _DriftKeyValueDB<int> {
  DriftIntKeyValueDB({required super.dao, required super.key});

  @override
  Future<int?> read() => _dao.readInt(_key);
}

final class DriftDoubleKeyValueDB extends _DriftKeyValueDB<double> {
  DriftDoubleKeyValueDB({required super.dao, required super.key});

  @override
  Future<double?> read() => _dao.readDouble(_key);
}

final class DriftBoolKeyValueDB extends _DriftKeyValueDB<bool> {
  DriftBoolKeyValueDB({required super.dao, required super.key});

  @override
  Future<bool?> read() => _dao.readBool(_key);
}
