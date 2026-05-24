import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';

/// {@template genres_random_wm}
/// Widget model for the genres random screen.
/// {@endtemplate}
abstract interface class IGenresRandomWM {
  /// Loads the list of genres.
  void read();

  /// Opens the list of all genres.
  void openGenres();

  /// Opens the genre screen.
  ///
  /// [genreId] - The ID of the genre to open.
  void openGenre(int genreId);
}

/// {@macro genres_random_wm}
///
/// Manages the genres random state and handles genres loading operations.
class GenresRandomWM implements IGenresRandomWM {
  /// {@macro genres_sm}
  final GenresSM _genresSM;

  /// {@macro genres_navigation_interactor}
  final IGenresNavigationInteractor _navigationInteractor;

  /// {@macro genres_random_wm}
  const GenresRandomWM({
    required this._genresSM,
    required this._navigationInteractor,
  });

  @override
  void read() {
    final state = _genresSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _genresSM.readLimit();
  }

  @override
  void openGenres() => _navigationInteractor.openGenres();

  @override
  void openGenre(int genreId) => _navigationInteractor.openGenre(genreId);
}
