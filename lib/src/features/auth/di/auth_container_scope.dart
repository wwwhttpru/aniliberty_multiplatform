import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_forget_password_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_login_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_reset_password_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/profile/profile.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template auth_container_input_scope}
/// Interface for input scope of Auth Container
/// {@endtemplate}
@immutable
final class AuthContainerInputScope {
  /// App url config
  final AppUrlConfig appUrlConfig;

  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// App database for accessing secure storage
  final IAppDatabase appDatabase;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// {@macro auth_container_input_scope}
  const AuthContainerInputScope({
    required this.appUrlConfig,
    required this.appNetwork,
    required this.appDatabase,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template auth_container_output_scope}
/// Interface for output scope of Auth Container
/// {@endtemplate}
abstract interface class AuthContainerOutputScope {
  /// Navigation interactor for authentication screens
  abstract final IAuthNavigationInteractor navigationInteractor;

  /// Login container state manager
  abstract final LoginContainerSM loginContainerSM;

  /// Profile container holder
  abstract final ProfileContainerHolder profileContainerHolder;

  /// Auth state manager
  abstract final AuthSM authSM;
}

/// {@template auth_container_scope}
/// Scope for Auth Container
/// {@endtemplate}
class AuthContainerScope extends DataScopeContainer<AuthContainerInputScope>
    implements AuthContainerOutputScope, AuthLoginContainerInputFactory {
  @override
  IAuthNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  LoginContainerSM get loginContainerSM => _loginContainerSM.get;

  @override
  ProfileContainerHolder get profileContainerHolder =>
      _profileContainerHolder.get;

  @override
  AuthSM get authSM => _authSM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_localDB},
    {_authInterceptor},
    {
      _authSM,
      _controller,
      _loginNodeSource,
      _forgetPasswordNodeSource,
      _resetPasswordNodeSource,
    },
    {
      _loginContainerSM,
      _forgetPasswordContainerSM,
      _resetPasswordContainerSM,
      _authProfileFlowInteractor,
    },
    {_navigationModule},
  ];

  AuthContainerScope({required super.data});

  /// {@macro auth_remote_db}
  late final _remoteDB = dep(
    () => AuthRemoteDB(
      appNetwork: data.appNetwork,
    ),
  );

  /// {@macro auth_local_db}
  late final _localDB = rawAsyncDep(
    () => AuthLocalDB(keyValueDB: data.appDatabase.authToken),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  /// {@macro auth_interceptor}
  late final _authInterceptor = rawAsyncDep<AuthInterceptor>(
    () => AuthInterceptor(
      appNetwork: data.appNetwork,
      localDB: _localDB.get,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  /// {@macro auth_repository}
  late final _repository = dep(
    () => AuthRepository(
      remoteDB: _remoteDB.get,
      localDB: _localDB.get,
    ),
  );

  /// {@macro auth_sm}
  late final _authSM = rawAsyncDep<AuthSM>(
    () => AuthSM(repository: _repository.get),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro auth_route}
  late final _route = dep<AuthRoute>(
    () => const AuthRoute(),
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro auth_navigation_interactor}
  late final _navigationInteractor = dep<IAuthNavigationInteractor>(
    () => AuthNavigationInteractor(
      route: _route.get,
      controller: _controller.get,
    ),
  );

  /// {@macro auth_navigation_module}
  late final _navigationModule = rawAsyncDep<AuthNavigationModule>(
    () => AuthNavigationModule(
      route: _route.get,
      loginContainerSM: _loginContainerSM.get,
      forgetPasswordContainerSM: _forgetPasswordContainerSM.get,
      resetPasswordContainerSM: _resetPasswordContainerSM.get,
      authSM: _authSM.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// {@macro login_node_source}
  late final _loginNodeSource = rawAsyncDep<LoginNodeSource>(
    () => LoginNodeSource(
      nodeReadable: data.navigationContainer.navigationController,
      route: _route.get,
      inputFactory: this,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro login_container_sm}
  late final _loginContainerSM = rawAsyncDep<LoginContainerSM>(
    () => LoginContainerSM(loginNodeSource: _loginNodeSource.get),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro forget_password_node_source}
  late final _forgetPasswordNodeSource = rawAsyncDep<ForgetPasswordNodeSource>(
    () => ForgetPasswordNodeSource(
      nodeReadable: data.navigationContainer.navigationController,
      route: _route.get,
      inputFactory: this,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro forget_password_container_sm}
  late final _forgetPasswordContainerSM =
      rawAsyncDep<ForgetPasswordContainerSM>(
        () => ForgetPasswordContainerSM(
          forgetPasswordNodeSource: _forgetPasswordNodeSource.get,
        ),
        init: (value) => value.init(),
        dispose: (value) => value.close(),
      );

  /// {@macro reset_password_node_source}
  late final _resetPasswordNodeSource = rawAsyncDep<ResetPasswordNodeSource>(
    () => ResetPasswordNodeSource(
      nodeReadable: data.navigationContainer.navigationController,
      route: _route.get,
      inputFactory: this,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  /// {@macro reset_password_container_sm}
  late final _resetPasswordContainerSM = rawAsyncDep<ResetPasswordContainerSM>(
    () => ResetPasswordContainerSM(
      resetPasswordNodeSource: _resetPasswordNodeSource.get,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  late final _profileContainerHolder = dep(ProfileContainerHolder.new);

  late final _profileContainerInputScope = dep(
    () => ProfileContainerInputScope(
      appNetwork: data.appNetwork,
      authRepository: _repository.get,
    ),
  );

  late final _authProfileFlowInteractor = rawAsyncDep(
    () => AuthProfileFlowInteractor(
      authSM: _authSM.get,
      profileContainerHolder: _profileContainerHolder.get,
      profileContainerInputScope: _profileContainerInputScope.get,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  /// {@macro auth_login_container_input_factory}
  @override
  AuthLoginContainerInputScope create() => AuthLoginContainerInputScope(
    appUrlConfig: data.appUrlConfig,
    navigationInteractor: navigationInteractor,
    repository: _repository.get,
  );

  /// {@macro auth_forget_password_container_input_factory}
  AuthForgetPasswordContainerInputScope createForgetPassword() =>
      AuthForgetPasswordContainerInputScope(
        navigationInteractor: navigationInteractor,
        repository: _repository.get,
      );

  /// Create input scope for Reset Password Container
  AuthResetPasswordContainerInputScope createResetPassword() =>
      AuthResetPasswordContainerInputScope(
        navigationInteractor: navigationInteractor,
        repository: _repository.get,
      );
}

/// {@template auth_container_holder}
/// Holder for Auth Container
/// {@endtemplate}
class AuthContainerHolder
    extends
        BaseDataScopeHolder<
          AuthContainerOutputScope,
          AuthContainerScope,
          AuthContainerInputScope
        > {
  /// {@macro auth_container_holder}
  AuthContainerHolder();

  @override
  AuthContainerScope createContainer(
    AuthContainerInputScope data,
  ) => AuthContainerScope(data: data);
}
