import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// {@template i_app_status_remote_db}
/// Interface for remote data source that provides app status data
/// {@endtemplate}
abstract interface class IAppStatusRemoteDB {
  /// Get app status
  ///
  /// Returns current app status including request info, alive status and available endpoints
  Future<AppStatusModel> getStatus();
}

/// {@macro i_app_status_remote_db}
///
/// Implementation of [IAppStatusRemoteDB] that uses the Anilibria API.
///
/// More information about the API: <https://anilibria.top/api/docs/v1#/>
@immutable
final class AppStatusRemoteDB implements IAppStatusRemoteDB {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_app_status_remote_db}
  ///
  /// Creates a new instance of [AppStatusRemoteDB].
  ///
  /// [_appNetwork] - The network client for API requests
  const AppStatusRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<AppStatusModel> getStatus() async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/app/status',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AppStatusModel.fromJson(data);
  }
}
