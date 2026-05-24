import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template auth_forget_password_container_input_scope}
/// Interface for input scope of Auth Forget Password Container
/// {@endtemplate}
@immutable
final class AuthForgetPasswordContainerInputScope {
  /// Navigation interactor for authentication screens
  final IAuthNavigationInteractor navigationInteractor;

  /// Authentication repository
  final IAuthRepository repository;

  /// {@macro auth_forget_password_container_input_scope}
  const AuthForgetPasswordContainerInputScope({
    required this.navigationInteractor,
    required this.repository,
  });

  @override
  int get hashCode => Object.hash(navigationInteractor, repository);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is AuthForgetPasswordContainerInputScope &&
        navigationInteractor == other.navigationInteractor &&
        repository == other.repository;
  }
}

/// {@template auth_forget_password_container_output_scope}
/// Interface for output scope of Auth Forget Password Container
/// {@endtemplate}
abstract interface class AuthForgetPasswordContainerOutputScope {
  /// Forget password form state manager
  abstract final ForgetPasswordFormSM forgetPasswordFormSM;

  /// Forget password state manager
  abstract final ForgetPasswordSM forgetPasswordSM;

  /// Forget password widget model
  abstract final IForgetPasswordWM forgetPasswordWM;
}

/// {@template auth_forget_password_container_scope}
/// Scope for Auth Forget Password Container
/// {@endtemplate}
class AuthForgetPasswordContainerScope
    extends DataScopeContainer<AuthForgetPasswordContainerInputScope>
    implements AuthForgetPasswordContainerOutputScope {
  @override
  ForgetPasswordFormSM get forgetPasswordFormSM => _forgetPasswordFormSM.get;

  @override
  ForgetPasswordSM get forgetPasswordSM => _forgetPasswordSM.get;

  @override
  IForgetPasswordWM get forgetPasswordWM => _forgetPasswordWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_forgetPasswordFormSM, _forgetPasswordSM},
    {_forgetPasswordFlowInteractor},
  ];

  AuthForgetPasswordContainerScope({required super.data});

  late final _forgetPasswordFormSM = rawAsyncDep(
    ForgetPasswordFormSM.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _forgetPasswordSM = rawAsyncDep(
    () => ForgetPasswordSM(repository: data.repository),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _forgetPasswordWM = dep(
    () => ForgetPasswordWM(
      forgetPasswordFormSM: _forgetPasswordFormSM.get,
      forgetPasswordSM: _forgetPasswordSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
  );

  late final _forgetPasswordFlowInteractor = rawAsyncDep(
    () => AuthForgetPasswordFlowInteractor(
      forgetPasswordSM: _forgetPasswordSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );
}

/// {@template auth_forget_password_container_holder}
/// Holder for forget password container scope
/// {@endtemplate}
class AuthForgetPasswordContainerHolder
    extends
        BaseDataScopeHolder<
          AuthForgetPasswordContainerOutputScope,
          AuthForgetPasswordContainerScope,
          AuthForgetPasswordContainerInputScope
        > {
  AuthForgetPasswordContainerHolder();

  @override
  AuthForgetPasswordContainerScope createContainer(
    AuthForgetPasswordContainerInputScope data,
  ) => AuthForgetPasswordContainerScope(data: data);
}
