import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template genre_releases_container_input_scope}
/// Dependencies required from outside for Genre Releases Container.
/// {@endtemplate}
@immutable
final class GenreReleasesContainerInputScope {
  /// {@macro genres_repository}
  final IGenresRepository repository;

  /// Genre identifier.
  final int genreId;

  /// {@macro genre_releases_container_input_scope}
  const GenreReleasesContainerInputScope({
    required this.repository,
    required this.genreId,
  });
}

/// {@template genre_releases_container_output_scope}
/// Dependencies provided by Genre Releases Container.
/// {@endtemplate}
abstract interface class GenreReleasesContainerOutputScope {
  /// State manager for genre releases.
  abstract final GenreReleasesSM genreReleasesSM;

  /// Widget model for genre releases.
  abstract final IGenreReleasesWM genreReleasesWM;
}

/// {@template genre_releases_container_scope}
/// Scope for a single genre releases container.
/// {@endtemplate}
class GenreReleasesContainerScope
    extends DataScopeContainer<GenreReleasesContainerInputScope>
    implements GenreReleasesContainerOutputScope {
  @override
  GenreReleasesSM get genreReleasesSM => _genreReleasesSM.get;

  @override
  IGenreReleasesWM get genreReleasesWM => _genreReleasesWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_genreReleasesSM},
  ];

  GenreReleasesContainerScope({required super.data});

  late final _genreReleasesSM = rawAsyncDep(
    () => GenreReleasesSM(
      genreId: data.genreId,
      repository: data.repository,
    ),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _genreReleasesWM = dep(
    () => GenreReleasesWM(genreReleasesSM: genreReleasesSM),
  );
}

/// {@template genre_releases_container_holder}
/// Holder for Genre Releases Container.
/// {@endtemplate}
class GenreReleasesContainerHolder
    extends
        BaseDataScopeHolder<
          GenreReleasesContainerOutputScope,
          GenreReleasesContainerScope,
          GenreReleasesContainerInputScope
        > {
  /// {@macro genre_releases_container_holder}
  GenreReleasesContainerHolder();

  @override
  GenreReleasesContainerScope createContainer(
    GenreReleasesContainerInputScope data,
  ) => GenreReleasesContainerScope(data: data);
}

/// {@template genre_releases_holder_factory}
/// Factory for creating genre releases container holders.
/// {@endtemplate}
abstract interface class IGenreReleasesHolderFactory {
  /// Creates a holder for a genre releases container.
  GenreReleasesContainerHolder create();

  /// Creates an input scope for a genre releases container.
  ///
  /// [genreId] is the identifier of the genre.
  GenreReleasesContainerInputScope createInputScope({
    required int genreId,
  });
}
