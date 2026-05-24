import 'dart:async';
import 'dart:collection';

import 'package:aniliberty_multiplatform/src/features/video_player/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/router/router.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_state/yx_state.dart';

/// Type alias for a map of episode IDs to their input scopes.
typedef EpisodeNode = Map<String, EpisodeContainerInputScope>;

/// Manages the state of episode nodes based on the current navigation route.
///
/// This class tracks which episode routes are currently open in the navigation tree
/// and maintains input scopes for each active episode. It automatically creates
/// new input scopes when episodes are opened and removes them when episodes are closed.
class EpisodeNodeSource extends StateManager<EpisodeNode> {
  /// Source of open route nodes in the navigation tree.
  final RouteNodeReadable _nodeReadable;

  /// Route configuration for video player episodes.
  final VideoPlayerRoute _route;

  /// Factory for creating input scopes for episode containers.
  final EpisodeContainerInputFactory _inputFactory;

  /// Subscription to route node changes.
  StreamSubscription<RouteNode>? _onNodeSub;

  /// Creates a new instance of [EpisodeNodeSource].
  ///
  /// [_nodeReadable] - The readable source of route nodes.
  /// [_route] - The video player route configuration.
  /// [_inputFactory] - Factory for creating episode input scopes.
  EpisodeNodeSource({
    required this._nodeReadable,
    required this._route,
    required this._inputFactory,
  }) : super(const {});

  /// Initializes the episode node source by subscribing to route node changes.
  ///
  /// This method should be called after creating an instance to start tracking
  /// episode routes. It sets up a stream subscription that listens for route changes.
  Future<void> init() async {
    assert(_onNodeSub == null, 'onNodeSub must be null');

    _onNodeSub ??= _nodeReadable.stream.whereType<RouteNode>().listen(
      _onNode,
    );

    return Future<void>.value();
  }

  /// Closes the episode node source and cancels all subscriptions.
  ///
  /// This method should be called when the source is no longer needed to prevent
  /// memory leaks from active subscriptions.
  @override
  Future<void> close() async {
    await _onNodeSub?.cancel();
    _onNodeSub = null;
    return super.close();
  }

  /// Handles route node changes and updates the episode node state accordingly.
  ///
  /// This method is called whenever the navigation route changes. It:
  /// 1. Traverses the route tree to find all active episode routes
  /// 2. Compares the current state with the new state
  /// 3. Creates input scopes for newly opened episodes
  /// 4. Removes input scopes for closed episodes
  /// 5. Emits the updated state
  void _onNode(RouteNode node) => handle(
    (emit) async {
      final nodes = <String>{};

      // Traverse the route tree to collect all active episode IDs
      node.traverse(
        (node) {
          final episodeId = _route.getEpisodeIDFromMap(node.arguments);

          if (episodeId == null) {
            return false;
          }

          nodes.add(episodeId);
          return false;
        },
        predicate: (node) {
          final isVideoNode = node.route == _route.video;
          final episodeId = _route.getEpisodeIDFromMap(node.arguments);
          return isVideoNode && episodeId != null;
        },
      );

      // Current list of episode IDs in the state
      final current = state.keys.toSet();

      // Calculate which episodes need to be created or removed
      final needToCreate = nodes.difference(current);
      final needToRemove = current.difference(nodes);

      // If there's nothing to create or remove, skip state update
      if (needToCreate.isEmpty && needToRemove.isEmpty) {
        return;
      }

      final newState = Map<String, EpisodeContainerInputScope>.from(state);

      // Remove input scopes for closed episodes
      needToRemove.forEach(newState.remove);

      // Create input scopes for newly opened episodes
      for (final key in needToCreate) {
        final inputScope = _inputFactory.create(key);
        newState[key] = inputScope;
      }

      // Emit the new state
      emit(UnmodifiableMapView(newState));
    },
    identifier: '_onNode',
  );

  /// Determines whether a state change should be emitted.
  ///
  /// Returns true if the current and next states are different,
  /// preventing unnecessary state updates.
  @override
  bool shouldEmit(
    EpisodeNode current,
    EpisodeNode next,
  ) => !mapEquals(current, next);
}
