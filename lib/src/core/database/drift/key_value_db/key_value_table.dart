import 'package:drift/drift.dart';

/// Table for storing key-value pairs
/// Supports String, int, double, and bool types
/// Automatically tracks creation and update dates
class KeyValueTable extends Table {
  @override
  String get tableName => 'key_value';

  /// The key (unique identifier)
  TextColumn get key => text().withLength(min: 1, max: 255)();

  /// The value - String
  TextColumn get vString => text().nullable()();

  /// The value - Int
  IntColumn get vInt => integer().nullable()();

  /// The value - Double
  RealColumn get vDouble => real().nullable()();

  /// The value - Bool
  BoolColumn get vBool => boolean().nullable()();

  /// Date when the record was created
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Date when the record was last updated
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}
