import 'dart:async';

import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

/// {@template i_anime_search_wm}
/// Interface for anime search widget model.
/// {@endtemplate}
abstract interface class IAnimeSearchWM {
  /// Opens the search.
  void open();

  /// Closes the search.
  void close();

  /// Processes the input text.
  void search(String value);

  /// Opens the release.
  ///
  /// [aliasOrId] - The alias or ID of the release.
  void openRelease(String aliasOrId);

  /// Search query.
  String get query;
}

/// {@macro i_anime_search_wm}
///
/// Implementation of [IAnimeSearchWM].
///
/// Manages the search functionality and navigation.
final class AnimeSearchWM implements IAnimeSearchWM {
  /// {@macro anime_search_sm}
  final AnimeSearchSM _animeSearchSM;

  /// {@macro i_search_navigation_interactor}
  final ISearchNavigationInteractor _searchNavigationInteractor;

  /// {@macro i_search_navigation_interactor}
  final IReleasesNavigationInteractor _releasesNavigationInteractor;

  /// Current search query.
  @override
  String query;

  /// Controller for the search query.
  StreamController<String>? _searchQueryController;

  /// Subscription for the search query.
  StreamSubscription<String>? _searchQuerySubscription;

  /// {@macro anime_search_wm}
  ///
  /// Creates a new instance of [AnimeSearchWM].
  ///
  /// [_animeSearchSM] - The state manager for the anime search.
  /// [_searchNavigationInteractor] - The interactor for the search navigation.
  /// [_releasesNavigationInteractor] - The interactor for the releases navigation.
  AnimeSearchWM({
    required this._animeSearchSM,
    required this._searchNavigationInteractor,
    required this._releasesNavigationInteractor,
  }) : query = '';

  @mustCallSuper
  Future<void> init() {
    _searchQueryController = StreamController<String>.broadcast();
    _searchQuerySubscription = _searchQueryController?.stream
        .debounceTime(const Duration(milliseconds: 300))
        .listen(_animeSearchSM.search);
    return Future<void>.value();
  }

  @mustCallSuper
  Future<void> dispose() async {
    await _searchQuerySubscription?.cancel();
    _searchQuerySubscription = null;
    await _searchQueryController?.close();
    _searchQueryController = null;
  }

  @override
  void open() => _searchNavigationInteractor.openSearch();

  @override
  void close() => _searchNavigationInteractor.closeSearch();

  @override
  void openRelease(String aliasOrId) {
    assert(aliasOrId.isNotEmpty, 'AliasOrId must not be empty');
    _releasesNavigationInteractor.openRelease(aliasOrId);
    _searchNavigationInteractor.closeSearch();
  }

  @override
  void search(String value) {
    assert(
      _searchQueryController != null,
      '_searchQueryController must not be null',
    );

    final newQuery = value.trim();
    if (newQuery == query) {
      return;
    }

    query = newQuery.trim();
    _searchQueryController?.add(query);
  }
}
