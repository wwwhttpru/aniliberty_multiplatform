import 'package:aniliberty_multiplatform/src/features/genres/domain/repository/genres_repository.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/state/genre_releases_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template genre_releases_sm}
/// State manager for the genre releases screen.
///
/// Holds [GenreReleasesState] and loads releases for a fixed genre
/// via [IGenresRepository]. Call [onPagination] when the user requests
/// the next page; state transitions idle → progress → success/error → idle.
/// {@endtemplate}
class GenreReleasesSM extends StateManager<GenreReleasesState> {
  /// Genre whose releases are displayed.
  final int _genreId;

  /// Repository used to fetch releases.
  final IGenresRepository _repository;

  /// Creates a state manager for the genre identified by [_genreId].
  ///
  /// [_repository] is used for pagination requests.
  GenreReleasesSM({
    required this._genreId,
    required this._repository,
  }) : super(const GenreReleasesState.idle());

  /// Loads the next page of releases and appends to the state list.
  ///
  /// No-op if the current pagination indicates the last page.
  void onPagination() {
    handle((emit) async {
      if (state.pagination.isEndOfPage) return;
      final currentPagination = state.pagination;
      final nextPage = currentPagination.nextPage;

      try {
        emit(
          GenreReleasesState.progress(
            release: state.release,
            pagination: currentPagination.copyWith(currentPage: nextPage),
          ),
        );

        final result = await _repository.readReleasesByGenreIdFromNetwork(
          genreId: _genreId,
          page: nextPage,
          limit: 15,
        );

        emit(
          GenreReleasesState.success(
            release: [...state.release, ...result.data],
            pagination: result.meta.pagination,
          ),
        );
      } on Object catch (error, sk) {
        emit(
          GenreReleasesState.error(
            release: state.release,
            pagination: state.pagination,
          ),
        );
        addError(error, sk);
      } finally {
        emit(
          GenreReleasesState.idle(
            release: state.release,
            pagination: state.pagination,
          ),
        );
      }
    });
  }
}
