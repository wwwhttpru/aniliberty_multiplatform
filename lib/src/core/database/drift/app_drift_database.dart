import 'package:aniliberty_multiplatform/src/core/database/drift/key_value_db/key_value_dao.dart';
import 'package:aniliberty_multiplatform/src/core/database/drift/key_value_db/key_value_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:meta/meta.dart';

part 'app_drift_database.g.dart';

@DriftDatabase(tables: [KeyValueTable], daos: [KeyValueDao])
class AppDriftDatabase extends _$AppDriftDatabase {
  /// {@macro drift_database}
  AppDriftDatabase(super.e);

  /// {@macro drift_database}
  AppDriftDatabase.name({required String name})
    : super(
        driftDatabase(
          name: name,
          native: const DriftNativeOptions(shareAcrossIsolates: true),

          /// See https://drift.simonbinder.eu/platforms/web/ to get more information about the web options.
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3_2.9.4.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  MigrationStrategy get migration => _MigrationStrategy(database: this);

  @override
  int get schemaVersion => 1;
}

@immutable
class _MigrationStrategy implements MigrationStrategy {
  // ignore: unused_field
  final AppDriftDatabase _database;

  const _MigrationStrategy({
    required this._database,
  });

  /// Signature of a function that's called before a database is marked opened by
  /// drift, but after migrations took place. This is a suitable callback to to
  /// populate initial data or issue `PRAGMA` statements that you want to use.
  @override
  OnBeforeOpen? get beforeOpen => (details) async {};

  /// Executes when the database is opened for the first time.
  @override
  OnCreate get onCreate => (m) async {
    await m.createAll();
  };

  /// Executes when the database has been opened previously, but the last access
  /// happened at a different [AppDriftDatabase.schemaVersion].
  /// Schema version upgrades and downgrades will both be run here.
  @override
  OnUpgrade get onUpgrade => (m, from, to) async {
    await m.createAll();
    if (from >= to) return;
  };
}
