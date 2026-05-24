import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template profile_wm}
/// Widget model for the profile screen
/// {@endtemplate}
abstract interface class IProfileWM {
  /// Open profile screen
  void openProfile();

  /// Log out user
  void logOut();

  /// Read profile data
  void read();
}

/// {@macro profile_wm}
@immutable
class ProfileWM implements IProfileWM {
  /// Profile state manager
  final ProfileSM _profileSM;

  /// Log out state manager
  final LogOutSM _logOutSM;

  /// {@macro profile_wm}
  const ProfileWM({
    required this._profileSM,
    required this._logOutSM,
  });

  @override
  void openProfile() {
    // TODO(wwwhttpru): Implement open profile screen
  }

  @override
  void read() => _profileSM.read();

  @override
  void logOut() => _logOutSM.logOut();
}
