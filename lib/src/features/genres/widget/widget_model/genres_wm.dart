import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template genres_wm}
/// Widget model for the genres screen.
/// {@endtemplate}
abstract interface class IGenresWM {
  /// Loads the list of genres.
  void read();

  /// Opens the genre screen.
  ///
  /// [genreId] - The ID of the genre to open.
  void openGenre(int genreId);

  /// Closes the genres screen.
  void closeGenres();
}

/// {@macro genres_wm}
///
/// Manages the genres state and handles genres loading operations.
@immutable
class GenresWM implements IGenresWM {
  /// {@macro genres_sm}
  final GenresSM _genresSM;

  /// {@macro genres_navigation_interactor}
  final IGenresNavigationInteractor _navigationInteractor;

  /// {@macro genres_wm}
  const GenresWM({
    required this._genresSM,
    required this._navigationInteractor,
  });

  @override
  void read() {
    final state = _genresSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _genresSM.read();
  }

  @override
  void openGenre(int genreId) => _navigationInteractor.openGenre(genreId);

  @override
  void closeGenres() => _navigationInteractor.closeGenres();
}
