import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template genre_releases_wm}
/// Widget model for the genre releases screen.
/// {@endtemplate}
abstract interface class IGenreReleasesWM {
  /// Called when the list is scrolled to load more data.
  void onScrollList();
}

/// {@macro genre_releases_wm}
///
/// Manages the genre releases state and handles releases loading operations.
@immutable
class GenreReleasesWM implements IGenreReleasesWM {
  /// {@macro genre_releases_sm}
  final GenreReleasesSM _genreReleasesSM;

  /// {@macro genre_releases_wm}
  const GenreReleasesWM({
    required this._genreReleasesSM,
  });

  @override
  void onScrollList() {
    if (_genreReleasesSM.state.isProgress) {
      return;
    }

    _genreReleasesSM.onPagination();
  }
}
