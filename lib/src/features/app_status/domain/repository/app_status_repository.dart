import 'package:aniliberty_multiplatform/src/datasource_v2/app_status/app_status.dart';

/// {@template i_app_status_repository}
/// Interface for app status repository
/// {@endtemplate}
abstract interface class IAppStatusRepository {
  /// Get app status
  ///
  /// Returns current app status including request info, alive status and available endpoints
  Future<AppStatusModel> getStatus();
}
