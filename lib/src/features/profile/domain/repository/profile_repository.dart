import 'package:aniliberty_multiplatform/src/datasource_v2/user/user.dart';

/// {@template i_profile_repository}
/// Interface for profile repository
/// {@endtemplate}
abstract interface class IProfileRepository {
  /// Get current user profile
  Future<UserProfileModel> getProfile();
}
