import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/auth/di/auth_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/di/auth_forget_password_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/auth/router/router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_state/yx_state.dart';

/// Manages the state of forget password node based on the current navigation route.
///
/// This class tracks whether the forget password route is currently open in the navigation tree
/// and maintains input scope for the active forget password. It automatically creates
/// new input scope when forget password is opened and removes it when forget password is closed.
class ForgetPasswordNodeSource
    extends StateManager<AuthForgetPasswordContainerInputScope?> {
  /// Source of open route nodes in the navigation tree.
  final RouteNodeReadable _nodeReadable;

  /// Route configuration for authentication screens.
  final AuthRoute _route;

  /// Factory for creating input scope for forget password container.
  final AuthContainerScope _inputFactory;

  /// Subscription to route node changes.
  StreamSubscription<RouteNode>? _onNodeSub;

  /// Creates a new instance of [ForgetPasswordNodeSource].
  ///
  /// [_nodeReadable] - The readable source of route nodes.
  /// [_route] - The authentication route configuration.
  /// [_inputFactory] - Factory for creating forget password input scopes.
  ForgetPasswordNodeSource({
    required this._nodeReadable,
    required this._route,
    required this._inputFactory,
  }) : super(null);

  /// Initializes the forget password node source by subscribing to route node changes.
  ///
  /// This method should be called after creating an instance to start tracking
  /// forget password routes. It sets up a stream subscription that listens for route changes.
  Future<void> init() async {
    assert(_onNodeSub == null, 'onNodeSub must be null');

    _onNodeSub ??= _nodeReadable.stream.whereType<RouteNode>().listen(
      _onNode,
    );

    return Future<void>.value();
  }

  /// Closes the forget password node source and cancels all subscriptions.
  ///
  /// This method should be called when the source is no longer needed to prevent
  /// memory leaks from active subscriptions.
  @override
  Future<void> close() async {
    await _onNodeSub?.cancel();
    _onNodeSub = null;
    return super.close();
  }

  /// Handles route node changes and updates the forget password node state accordingly.
  ///
  /// This method is called whenever the navigation route changes. It:
  /// 1. Traverses the route tree to find if forget password route is active
  /// 2. Creates input scope if forget password route is opened
  /// 3. Removes input scope if forget password route is closed
  /// 4. Emits the updated state
  void _onNode(RouteNode node) => handle(
    (emit) async {
      var isForgetPasswordOpen = false;

      // Traverse the route tree to check if forget password route is active
      node.traverse(
        (node) {
          isForgetPasswordOpen = true;
          return true; // Stop traversal once found
        },
        predicate: (node) => node.route == _route.forgetPassword,
      );

      // If forget password route is not open and state is null, or forget password is open and state is not null
      // skip state update
      if ((!isForgetPasswordOpen && state == null) ||
          (isForgetPasswordOpen && state != null)) {
        return;
      }

      // Create or remove input scope based on forget password route state
      final newState = isForgetPasswordOpen
          ? _inputFactory.createForgetPassword()
          : null;

      // Emit the new state
      emit(newState);
    },
    identifier: '_onNode',
  );
}
