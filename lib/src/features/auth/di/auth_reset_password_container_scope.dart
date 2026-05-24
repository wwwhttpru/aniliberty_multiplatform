import 'package:aniliberty_multiplatform/src/features/auth/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/auth/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template auth_reset_password_container_input_scope}
/// Interface for input scope of Auth Reset Password Container
/// {@endtemplate}
@immutable
final class AuthResetPasswordContainerInputScope {
  /// Navigation interactor for authentication screens
  final IAuthNavigationInteractor navigationInteractor;

  /// Authentication repository
  final IAuthRepository repository;

  /// {@macro auth_reset_password_container_input_scope}
  const AuthResetPasswordContainerInputScope({
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
    return other is AuthResetPasswordContainerInputScope &&
        navigationInteractor == other.navigationInteractor &&
        repository == other.repository;
  }
}

/// {@template auth_reset_password_container_output_scope}
/// Interface for output scope of Auth Reset Password Container
/// {@endtemplate}
abstract interface class AuthResetPasswordContainerOutputScope {
  /// Reset password form state manager
  abstract final ResetPasswordFormSM resetPasswordFormSM;

  /// Reset password state manager
  abstract final ResetPasswordSM resetPasswordSM;

  /// Reset password widget model
  abstract final IResetPasswordWM resetPasswordWM;
}

/// {@template auth_reset_password_container_scope}
/// Scope for Auth Reset Password Container
/// {@endtemplate}
class AuthResetPasswordContainerScope
    extends DataScopeContainer<AuthResetPasswordContainerInputScope>
    implements AuthResetPasswordContainerOutputScope {
  @override
  ResetPasswordFormSM get resetPasswordFormSM => _resetPasswordFormSM.get;

  @override
  ResetPasswordSM get resetPasswordSM => _resetPasswordSM.get;

  @override
  IResetPasswordWM get resetPasswordWM => _resetPasswordWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_resetPasswordFormSM, _resetPasswordSM},
    {_resetPasswordFlowInteractor},
  ];

  AuthResetPasswordContainerScope({required super.data});

  late final _resetPasswordFormSM = rawAsyncDep(
    ResetPasswordFormSM.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _resetPasswordSM = rawAsyncDep(
    () => ResetPasswordSM(repository: data.repository),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _resetPasswordWM = dep(
    () => ResetPasswordWM(
      resetPasswordFormSM: _resetPasswordFormSM.get,
      resetPasswordSM: _resetPasswordSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
  );

  late final _resetPasswordFlowInteractor = rawAsyncDep(
    () => AuthResetPasswordFlowInteractor(
      resetPasswordSM: _resetPasswordSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );
}

/// {@template auth_reset_password_container_holder}
/// Holder for reset password container scope
/// {@endtemplate}
class AuthResetPasswordContainerHolder
    extends
        BaseDataScopeHolder<
          AuthResetPasswordContainerOutputScope,
          AuthResetPasswordContainerScope,
          AuthResetPasswordContainerInputScope
        > {
  AuthResetPasswordContainerHolder();

  @override
  AuthResetPasswordContainerScope createContainer(
    AuthResetPasswordContainerInputScope data,
  ) => AuthResetPasswordContainerScope(data: data);
}
