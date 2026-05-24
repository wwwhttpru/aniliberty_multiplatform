import 'package:aniliberty_multiplatform/src/core/database/drift/app_drift_database.dart';
import 'package:aniliberty_multiplatform/src/core/database/drift/key_value_db/key_value_table.dart';
import 'package:drift/drift.dart';

part 'key_value_dao.g.dart';

/// Data Access Object for key-value operations
@DriftAccessor(tables: [KeyValueTable])
class KeyValueDao extends DatabaseAccessor<AppDriftDatabase>
    with _$KeyValueDaoMixin {
  KeyValueDao(super.attachedDatabase);

  /// Set a key-value pair
  Future<void> createOrUpdate(String key, Object? value) async {
    if (value == null) {
      await deleteKeyValue(key);
      return;
    }

    final companion = _companionFromKeyValue(key, value);
    if (companion == null) {
      assert(companion != null, 'Type of value is not supported');
      return;
    }
    await into(keyValueTable).insertOnConflictUpdate(companion);
  }

  Future<String?> readString(String key) async {
    final ds = await readKeyValue(key);
    return ds?.vString;
  }

  Future<int?> readInt(String key) async {
    final ds = await readKeyValue(key);
    return ds?.vInt;
  }

  Future<double?> readDouble(String key) async {
    final ds = await readKeyValue(key);
    return ds?.vDouble;
  }

  Future<bool?> readBool(String key) async {
    final ds = await readKeyValue(key);
    return ds?.vBool;
  }

  /// Delete a key-value pair
  Future<void> deleteKeyValue(String key) async {
    final ds = delete(keyValueTable)..where((t) => t.key.equals(key));
    await ds.go();
  }

  Future<KeyValueTableData?> readKeyValue(String key) async {
    final ds = select(keyValueTable)..where((t) => t.key.equals(key));
    return ds.getSingleOrNull();
  }

  /// Create a companion from a key-value pair
  KeyValueTableCompanion? _companionFromKeyValue(String key, Object? value) =>
      switch (value) {
        final String vString => KeyValueTableCompanion.insert(
          key: key,
          vString: Value(vString),
        ),
        final int vInt => KeyValueTableCompanion.insert(
          key: key,
          vInt: Value(vInt),
        ),
        final double vDouble => KeyValueTableCompanion.insert(
          key: key,
          vDouble: Value(vDouble),
        ),
        final bool vBool => KeyValueTableCompanion.insert(
          key: key,
          vBool: Value(vBool),
        ),
        _ => null,
      };
}
