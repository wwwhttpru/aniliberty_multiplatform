import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_login_container_scope.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_state/yx_state.dart';

/// State type representing the login container output scope.
typedef LoginContainerState = AuthLoginContainerOutputScope?;

/// {@template login_container_sm}
/// State manager for login container.
///
/// Manages the lifecycle of login container based on available login node.
/// Automatically creates container when login is opened and disposes container
/// when login is closed. The container has its own dependency injection scope.
/// {@endtemplate}
class LoginContainerSM extends StateManager<LoginContainerState> {
  /// Source of available login node
  final LoginNodeSource _loginNodeSource;

  /// Storage for login container holder
  AuthLoginContainerHolder? _holder;

  /// Subscription to changes in available login node
  StreamSubscription<AuthLoginContainerInputScope?>? _onLoginNodeSub;

  /// {@macro login_container_sm}
  LoginContainerSM({
    required this._loginNodeSource,
  }) : super(null);

  /// Initializes the state manager and starts listening to login node changes.
  ///
  /// Sets up a stream subscription to monitor changes in available login node
  /// and automatically create/dispose container as needed.
  Future<void> init() {
    assert(
      _onLoginNodeSub == null,
      'onLoginNodeSub must be null',
    );

    _onLoginNodeSub ??= _loginNodeSource.stream
        .startWith(_loginNodeSource.state)
        .distinct()
        .listen(_onLoginNode);

    return Future<void>.value();
  }

  /// Closes the state manager and disposes the login container.
  ///
  /// Cancels subscriptions and cleans up all resources.
  @override
  Future<void> close() {
    assert(
      _onLoginNodeSub != null,
      'onLoginNodeSub must not be null',
    );

    _onLoginNodeSub?.cancel();
    _onLoginNodeSub = null;

    _clear();
    return super.close();
  }

  /// Handler for changes in available login node.
  ///
  /// Creates container when login is opened and disposes container when login is closed.
  /// Updates the state with the new login container.
  void _onLoginNode(AuthLoginContainerInputScope? loginNode) => handle(
    (emit) async {
      final current = state;
      final input = loginNode;

      // If login node is null and state is null, or login node is not null and state is not null
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
        final holder = AuthLoginContainerHolder();
        await holder.create(input);

        final scope = holder.scope;
        if (scope == null) {
          assert(false, 'Login scope must not be null');
          return;
        }

        _holder = holder;
        emit(scope);
      }
    },
    identifier: '_onLoginNode',
  );

  /// Clears the login container and resets state to null.
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
    LoginContainerState current,
    LoginContainerState next,
  ) => current != next;
}
