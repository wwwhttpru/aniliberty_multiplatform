import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_reset_password_container_scope.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_state/yx_state.dart';

/// State type representing the reset password container output scope.
typedef ResetPasswordContainerState = AuthResetPasswordContainerOutputScope?;

/// {@template reset_password_container_sm}
/// State manager for reset password container.
///
/// Manages the lifecycle of reset password container based on available reset password node.
/// Automatically creates container when reset password is opened and disposes container
/// when reset password is closed. The container has its own dependency injection scope.
/// {@endtemplate}
class ResetPasswordContainerSM
    extends StateManager<ResetPasswordContainerState> {
  /// Source of available reset password node
  final ResetPasswordNodeSource _resetPasswordNodeSource;

  /// Storage for reset password container holder
  AuthResetPasswordContainerHolder? _holder;

  /// Subscription to changes in available reset password node
  StreamSubscription<AuthResetPasswordContainerInputScope?>?
  _onResetPasswordNodeSub;

  /// {@macro reset_password_container_sm}
  ResetPasswordContainerSM({
    required this._resetPasswordNodeSource,
  }) : super(null);

  /// Initializes the state manager and starts listening to reset password node changes.
  ///
  /// Sets up a stream subscription to monitor changes in available reset password node
  /// and automatically create/dispose container as needed.
  Future<void> init() {
    assert(
      _onResetPasswordNodeSub == null,
      'onResetPasswordNodeSub must be null',
    );

    _onResetPasswordNodeSub ??= _resetPasswordNodeSource.stream
        .startWith(_resetPasswordNodeSource.state)
        .distinct()
        .listen(_onResetPasswordNode);

    return Future<void>.value();
  }

  /// Closes the state manager and disposes the reset password container.
  ///
  /// Cancels subscriptions and cleans up all resources.
  @override
  Future<void> close() {
    assert(
      _onResetPasswordNodeSub != null,
      'onResetPasswordNodeSub must not be null',
    );

    _onResetPasswordNodeSub?.cancel();
    _onResetPasswordNodeSub = null;

    _clear();
    return super.close();
  }

  /// Handler for changes in available reset password node.
  ///
  /// Creates container when reset password is opened and disposes container when reset password is closed.
  /// Updates the state with the new reset password container.
  void _onResetPasswordNode(
    AuthResetPasswordContainerInputScope? resetPasswordNode,
  ) => handle(
    (emit) async {
      final current = state;
      final input = resetPasswordNode;

      // If reset password node is null and state is null, or reset password node is not null and state is not null
      // with the same input, skip state update
      if ((input == null && current == null) ||
          (input != null && current != null)) {
        return;
      }

      // Remove old container
      if (input == null && current != null) {
        await _holder?.drop();
        _holder = null;
        emit(null);
        return;
      }

      // Create new container
      if (input != null) {
        final holder = AuthResetPasswordContainerHolder();
        await holder.create(input);

        final scope = holder.scope;
        if (scope == null) {
          assert(false, 'ResetPassword scope must not be null');
          return;
        }

        _holder = holder;
        emit(scope);
      }
    },
    identifier: '_onResetPasswordNode',
  );

  /// Clears the reset password container and resets state to null.
  void _clear() => handle(
    (emit) async {
      if (_holder != null) {
        await _holder?.drop();
        _holder = null;
      }
      emit(null);
    },
    identifier: '_clear',
  );

  @override
  bool shouldEmit(
    ResetPasswordContainerState current,
    ResetPasswordContainerState next,
  ) => current != next;
}
