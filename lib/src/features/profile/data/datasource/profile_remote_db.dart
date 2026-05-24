import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/user/user.dart';
import 'package:meta/meta.dart';

/// {@template i_profile_remote_db}
/// Interface for remote data source that provides profile data
/// {@endtemplate}
abstract interface class IProfileRemoteDB {
  /// Get current user profile
  ///
  /// Returns profile data for authenticated user
  Future<UserProfileModel> getProfile();
}

/// {@macro i_profile_remote_db}
///
/// For more API details: <https://anilibria.top/api/docs/v1#/>
@immutable
final class ProfileRemoteDB implements IProfileRemoteDB {
  final AppNetwork _appNetwork;

  /// {@macro i_profile_remote_db}
  const ProfileRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<UserProfileModel> getProfile() async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/accounts/users/me/profile',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return UserProfileModel.fromJson(data);
  }
}
