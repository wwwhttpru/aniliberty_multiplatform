import 'package:aniliberty_multiplatform/src/features/genres/domain/repository/genres_repository.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/state/genres_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template genres_sm}
/// State manager for the genres list screen.
///
/// Holds [GenresState] and loads genres via [IGenresRepository].
/// Use [read] for the full list or [readLimit] for a random subset of size [limit].
/// {@endtemplate}
class GenresSM extends StateManager<GenresState> {
  /// Repository used to fetch genres.
  final IGenresRepository _repository;

  /// Creates a state manager with the given [_repository].
  GenresSM({
    required this._repository,
  }) : super(const GenresState.idle());

  /// Number of random genres returned by [readLimit].
  static const int limit = 6;

  /// Loads the full genre list and emits success or error.
  void read() => handle(
    (emit) async {
      try {
        emit(const GenresState.progress());
        final animeGenres = await _repository.readGenresFromNetwork();
        emit(GenresState.success(animeGenres: animeGenres));
      } on Object catch (error, sk) {
        emit(const GenresState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );

  /// Loads [limit] random genres and emits success or error.
  void readLimit() => handle(
    (emit) async {
      try {
        emit(const GenresState.progress());
        final animeGenres = await _repository.readRandomGenresFromNetwork(
          limit: limit,
        );
        emit(GenresState.success(animeGenres: animeGenres));
      } on Object catch (error, sk) {
        emit(const GenresState.error());
        addError(error, sk);
      }
    },
    identifier: 'readLimit',
  );
}
