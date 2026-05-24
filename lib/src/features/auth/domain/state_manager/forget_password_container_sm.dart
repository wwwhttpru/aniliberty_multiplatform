import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_forget_password_container_scope.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_state/yx_state.dart';

/// State type representing the forget password container output scope.
typedef ForgetPasswordContainerState = AuthForgetPasswordContainerOutputScope?;

/// {@template forget_password_container_sm}
/// State manager for forget password container.
///
/// Manages the lifecycle of forget password container based on available forget password node.
/// Automatically creates container when forget password is opened and disposes container
/// when forget password is closed. The container has its own dependency injection scope.
/// {@endtemplate}
class ForgetPasswordContainerSM
    extends StateManager<ForgetPasswordContainerState> {
  /// Source of available forget password node
  final ForgetPasswordNodeSource _forgetPasswordNodeSource;

  /// Storage for forget password container holder
  AuthForgetPasswordContainerHolder? _holder;

  /// Subscription to changes in available forget password node
  StreamSubscription<AuthForgetPasswordContainerInputScope?>?
  _onForgetPasswordNodeSub;

  /// {@macro forget_password_container_sm}
  ForgetPasswordContainerSM({
    required this._forgetPasswordNodeSource,
  }) : super(null);

  /// Initializes the state manager and starts listening to forget password node changes.
  ///
  /// Sets up a stream subscription to monitor changes in available forget password node
  /// and automatically create/dispose container as needed.
  Future<void> init() {
    assert(
      _onForgetPasswordNodeSub == null,
      'onForgetPasswordNodeSub must be null',
    );

    _onForgetPasswordNodeSub ??= _forgetPasswordNodeSource.stream
        .startWith(_forgetPasswordNodeSource.state)
        .distinct()
        .listen(_onForgetPasswordNode);

    return Future<void>.value();
  }

  /// Closes the state manager and disposes the forget password container.
  ///
  /// Cancels subscriptions and cleans up all resources.
  @override
  Future<void> close() {
    assert(
      _onForgetPasswordNodeSub != null,
      'onForgetPasswordNodeSub must not be null',
    );

    _onForgetPasswordNodeSub?.cancel();
    _onForgetPasswordNodeSub = null;

    _clear();
    return super.close();
  }

  /// Handler for changes in available forget password node.
  ///
  /// Creates container when forget password is opened and disposes container when forget password is closed.
  /// Updates the state with the new forget password container.
  void _onForgetPasswordNode(
    AuthForgetPasswordContainerInputScope? forgetPasswordNode,
  ) => handle(
    (emit) async {
      final current = state;
      final input = forgetPasswordNode;

      // If forget password node is null and state is null, or forget password node is not null and state is not null
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
        final holder = AuthForgetPasswordContainerHolder();
        await holder.create(input);

        final scope = holder.scope;
        if (scope == null) {
          assert(false, 'ForgetPassword scope must not be null');
          return;
        }

        _holder = holder;
        emit(scope);
      }
    },
    identifier: '_onForgetPasswordNode',
  );

  /// Clears the forget password container and resets state to null.
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
    ForgetPasswordContainerState current,
    ForgetPasswordContainerState next,
  ) => current != next;
}
