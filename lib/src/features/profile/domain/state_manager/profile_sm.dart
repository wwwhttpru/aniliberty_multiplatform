import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:yx_state/yx_state.dart';

/// {@template profile_sm}
/// State manager for profile feature
/// {@endtemplate}
final class ProfileSM extends StateManager<ProfileState> {
  /// {@macro i_profile_repository}
  final IProfileRepository _repository;

  /// {@macro profile_sm}
  ProfileSM({
    required this._repository,
  }) : super(const ProfileState.idle());

  /// Initializes the profile state manager.
  Future<void> init() {
    read();
    return Future<void>.value();
  }

  /// Reads the profile from the repository.
  void read() => handle(
    (emit) async {
      emit(const ProfileState.progress());
      try {
        final profile = await _repository.getProfile();
        emit(ProfileState.success(profile: profile));
      } on Object catch (error, sk) {
        emit(const ProfileState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );
}
