import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/data/datasource/app_status_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template app_status_repository}
/// Repository for app status operations
/// {@endtemplate}
@immutable
final class AppStatusRepository implements IAppStatusRepository {
  /// {@macro i_app_status_remote_db}
  final IAppStatusRemoteDB _remoteDB;

  /// {@macro app_status_repository}
  const AppStatusRepository({
    required this._remoteDB,
  });

  @override
  Future<AppStatusModel> getStatus() => _remoteDB.getStatus();
}
