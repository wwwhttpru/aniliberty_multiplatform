import 'package:aniliberty_multiplatform/src/features/search/domain/repository/search_repository.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/state/anime_search_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template anime_search_sm}
/// State manager for anime search feature.
///
/// Manages the search state and handles search operations.
/// {@endtemplate}
class AnimeSearchSM extends StateManager<AnimeSearchState> {
  /// {@macro i_search_repository}
  final ISearchRepository _repository;

  /// {@macro anime_search_sm}
  ///
  /// Creates a new instance of [AnimeSearchSM].
  ///
  /// [_repository] - The repository for search operations
  AnimeSearchSM({
    required this._repository,
  }) : super(const AnimeSearchState.idle());

  /// Searches for anime releases by query.
  ///
  /// If [query] is empty, sets state to [AnimeSearchState.idle].
  /// Otherwise, performs search and updates state accordingly:
  /// - Sets state to [AnimeSearchState.progress] while searching
  /// - Sets state to [AnimeSearchState.success] with results on success
  /// - Sets state to [AnimeSearchState.error] on failure
  ///
  /// [query] - The search query string
  void search(String query) => handle(
    (emit) async {
      if (query.isEmpty) {
        emit(const AnimeSearchState.idle());
        return;
      }

      emit(const AnimeSearchState.progress());

      try {
        final animeSearch = await _repository.searchReleases(query);
        emit(AnimeSearchState.success(animeSearch: animeSearch));
      } on Object catch (error, sk) {
        emit(const AnimeSearchState.error());
        addError(error, sk);
      }
    },
    identifier: 'search',
  );
}
