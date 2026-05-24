import 'dart:async';
import 'dart:collection';

import 'package:aniliberty_multiplatform/src/features/video_player/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yx_state/yx_state.dart';

/// State type representing a map of episode identifiers to their output scopes.
typedef EpisodeContainerState = Map<String, EpisodeContainerOutputScope>;

/// State manager for episode containers.
///
/// Manages the lifecycle of episode containers based on available episodes.
/// Automatically creates containers for new episodes and disposes containers
/// for removed episodes. Each container has its own dependency injection scope.
class EpisodeContainerSM extends StateManager<EpisodeContainerState> {
  /// Source of available episodes
  final EpisodeNodeSource _episodeNodeSource;

  /// Storage for episode container holders
  final _holders = <String, EpisodeContainerHolder>{};

  /// Subscription to changes in available episodes
  StreamSubscription<EpisodeNode>? _onEpisodeNodeSub;

  EpisodeContainerSM({
    required this._episodeNodeSource,
  }) : super(const {});

  /// Initializes the state manager and starts listening to episode changes.
  ///
  /// Sets up a stream subscription to monitor changes in available episodes
  /// and automatically create/dispose containers as needed.
  Future<void> init() {
    assert(
      _onEpisodeNodeSub == null,
      'onEpisodeNodeSub must be null',
    );

    _onEpisodeNodeSub ??= _episodeNodeSource.stream
        .startWith(_episodeNodeSource.state)
        .distinct()
        .listen(_onEpisodeNode);

    return Future<void>.value();
  }

  /// Closes the state manager and disposes all episode containers.
  ///
  /// Cancels subscriptions and cleans up all resources.
  @override
  Future<void> close() {
    assert(
      _onEpisodeNodeSub != null,
      'onEpisodeNodeSub must not be null',
    );

    _onEpisodeNodeSub?.cancel();
    _onEpisodeNodeSub = null;

    _clear();
    return super.close();
  }

  /// Handler for changes in available episodes.
  ///
  /// Creates containers for new episodes and disposes containers for removed episodes.
  /// Updates the state with the new set of episode containers.
  void _onEpisodeNode(EpisodeNode episodeNode) => handle(
    (emit) async {
      final current = state.keys.toSet();
      final aliasOrIds = episodeNode.keys.toSet();

      // Collect lists for creation and removal
      final needToCreate = aliasOrIds.difference(current);
      final needToRemove = current.difference(aliasOrIds);

      // Create new state
      final newState = Map<String, EpisodeContainerOutputScope>.from(state);

      // Remove old containers
      for (final key in needToRemove) {
        await _holders[key]?.drop();
        newState.remove(key);
      }

      // Create new containers
      for (final key in needToCreate) {
        final input = episodeNode[key];
        if (input == null) {
          assert(false, 'Episode input must not be null');
          continue;
        }

        final holder = EpisodeContainerHolder();
        await holder.create(input);

        final scope = holder.scope;
        if (scope == null) {
          assert(false, 'Episode scope must not be null');
          continue;
        }

        _holders[key] = holder;
        newState[key] = scope;
      }

      // Emit new state
      emit(UnmodifiableMapView(newState));
    },
    identifier: '_onEpisodeNode',
  );

  /// Clears all episode containers and resets state to empty.
  void _clear() => handle(
    (emit) async {
      for (final holder in _holders.values) {
        await holder.drop();
      }
      _holders.clear();
      emit(const {});
    },
    identifier: '_clear',
  );

  @override
  bool shouldEmit(
    EpisodeContainerState current,
    EpisodeContainerState next,
  ) => !mapEquals(current, next);
}
