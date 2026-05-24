import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template auth_login_container_input_factory}
/// Factory for creating input scope for login container
/// {@endtemplate}
abstract interface class AuthLoginContainerInputFactory {
  /// Create input scope for Login Container
  AuthLoginContainerInputScope create();
}

/// {@template auth_login_container_input_scope}
/// Interface for input scope of Auth Login Container
/// {@endtemplate}
@immutable
final class AuthLoginContainerInputScope {
  /// App url config
  final AppUrlConfig appUrlConfig;

  /// Navigation interactor for authentication screens
  final IAuthNavigationInteractor navigationInteractor;

  /// Authentication repository
  final IAuthRepository repository;

  /// {@macro auth_login_container_input_scope}
  const AuthLoginContainerInputScope({
    required this.appUrlConfig,
    required this.navigationInteractor,
    required this.repository,
  });

  @override
  int get hashCode =>
      Object.hash(appUrlConfig, navigationInteractor, repository);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthLoginContainerInputScope &&
        appUrlConfig == other.appUrlConfig &&
        navigationInteractor == other.navigationInteractor &&
        repository == other.repository;
  }
}

/// {@template auth_login_container_output_scope}
/// Interface for output scope of Auth Login Container
/// {@endtemplate}
abstract interface class AuthLoginContainerOutputScope {
  /// Login form state manager
  abstract final LoginFormSM loginFormSM;

  /// Login state manager
  abstract final LoginSM loginSM;

  /// Login widget model
  abstract final ILoginWM loginWM;
}

/// {@template auth_login_container_scope}
/// Scope for Auth Login Container
/// {@endtemplate}
class AuthLoginContainerScope
    extends DataScopeContainer<AuthLoginContainerInputScope>
    implements AuthLoginContainerOutputScope {
  @override
  LoginFormSM get loginFormSM => _loginFormSM.get;

  @override
  LoginSM get loginSM => _loginSM.get;

  @override
  ILoginWM get loginWM => _loginWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_loginFormSM, _loginSM, _urlLauncher},
    {_loginFlowInteractor},
  ];

  AuthLoginContainerScope({required super.data});

  late final _loginFormSM = rawAsyncDep(
    LoginFormSM.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _loginSM = rawAsyncDep(
    () => LoginSM(repository: data.repository),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _urlLauncher = rawAsyncDep(
    UrlLauncherStateManager.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _loginWM = dep(
    () => LoginWM(
      loginFormSM: _loginFormSM.get,
      loginSM: _loginSM.get,
      navigationInteractor: data.navigationInteractor,
      appUrlConfig: data.appUrlConfig,
      urlLauncher: _urlLauncher.get,
    ),
  );

  late final _loginFlowInteractor = rawAsyncDep(
    () => AuthLoginFlowInteractor(
      loginSM: _loginSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );
}

/// {@template auth_login_container_holder}
/// Holder for login container scope
/// {@endtemplate}
class AuthLoginContainerHolder
    extends
        BaseDataScopeHolder<
          AuthLoginContainerOutputScope,
          AuthLoginContainerScope,
          AuthLoginContainerInputScope
        > {
  AuthLoginContainerHolder();

  @override
  AuthLoginContainerScope createContainer(
    AuthLoginContainerInputScope data,
  ) => AuthLoginContainerScope(data: data);
}
