import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/profile/data/datasource/profile_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template profile_repository}
/// Repository for profile operations
/// {@endtemplate}
@immutable
final class ProfileRepository implements IProfileRepository {
  /// {@macro i_profile_remote_db}
  final IProfileRemoteDB _remoteDB;

  /// {@macro profile_repository}
  const ProfileRepository({
    required this._remoteDB,
  });

  @override
  Future<UserProfileModel> getProfile() => _remoteDB.getProfile();
}
