import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/auth.dart';
import 'package:aniliberty_multiplatform/src/features/profile/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/profile/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/profile/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template profile_container_input_scope}
/// Interface for input scope of Profile Container
/// {@endtemplate}
@immutable
final class ProfileContainerInputScope {
  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// Auth repository to use for auth operations
  final IAuthRepository authRepository;

  /// {@macro profile_container_input_scope}
  const ProfileContainerInputScope({
    required this.appNetwork,
    required this.authRepository,
  });
}

/// {@template profile_container_output_scope}
/// Interface for output scope of Profile Container
/// {@endtemplate}
abstract interface class ProfileContainerOutputScope {
  /// Profile state manager
  abstract final ProfileSM profileSM;

  /// Log out state manager
  abstract final LogOutSM logOutSM;

  /// Profile widget model
  abstract final IProfileWM profileWM;
}

/// {@template profile_container_scope}
/// Scope for Profile Container
/// {@endtemplate}
class ProfileContainerScope
    extends DataScopeContainer<ProfileContainerInputScope>
    implements ProfileContainerOutputScope {
  @override
  ProfileSM get profileSM => _profileSM.get;

  @override
  LogOutSM get logOutSM => _logOutSM.get;

  @override
  IProfileWM get profileWM => _profileWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_profileSM, _logOutSM},
  ];

  ProfileContainerScope({required super.data});

  /// {@macro i_profile_remote_db}
  late final _remoteDB = dep<IProfileRemoteDB>(
    () => ProfileRemoteDB(
      appNetwork: data.appNetwork,
    ),
  );

  /// {@macro i_profile_repository}
  late final _repository = dep<IProfileRepository>(
    () => ProfileRepository(
      remoteDB: _remoteDB.get,
    ),
  );

  /// {@macro profile_sm}
  late final _profileSM = rawAsyncDep<ProfileSM>(
    () => ProfileSM(repository: _repository.get),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro log_out_sm}
  late final _logOutSM = rawAsyncDep<LogOutSM>(
    () => LogOutSM(repository: data.authRepository),
    init: (value) async {},
    dispose: (value) async => value.close(),
  );

  /// {@macro profile_wm}
  late final _profileWM = dep<IProfileWM>(
    () => ProfileWM(
      profileSM: _profileSM.get,
      logOutSM: _logOutSM.get,
    ),
  );
}

/// {@template profile_container_holder}
/// Holder for Profile Container
/// {@endtemplate}
class ProfileContainerHolder
    extends
        BaseDataScopeHolder<
          ProfileContainerOutputScope,
          ProfileContainerScope,
          ProfileContainerInputScope
        > {
  /// {@macro profile_container_holder}
  ProfileContainerHolder();

  @override
  ProfileContainerScope createContainer(
    ProfileContainerInputScope data,
  ) => ProfileContainerScope(data: data);
}
