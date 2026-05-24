import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/genres/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/genres/di/genre_releases_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template genres_container_input_scope}
/// Dependencies required from outside for Genres Container.
/// {@endtemplate}
@immutable
final class GenresContainerInputScope {
  /// App network for network operations.
  final AppNetwork appNetwork;

  /// Navigation container for creating navigation controller.
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for feed tab navigation.
  final RouteNodeResolver routeResolver;

  /// {@macro genres_container_input_scope}
  const GenresContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template genres_container_output_scope}
/// Dependencies provided by Genres Container.
/// {@endtemplate}
abstract interface class GenresContainerOutputScope {
  /// Genres navigation interactor.
  abstract final IGenresNavigationInteractor navigationInteractor;

  /// State manager for genres list.
  abstract final GenresSM genresSM;

  /// State manager for random genres.
  abstract final GenresSM genresRandomSM;

  /// Widget model for genres list.
  abstract final IGenresWM genresWM;

  /// Widget model for random genres.
  abstract final IGenresRandomWM genresRandomWM;
}

/// {@template genres_container_scope}
/// Scope for Genres Container.
/// {@endtemplate}
class GenresContainerScope extends DataScopeContainer<GenresContainerInputScope>
    implements GenresContainerOutputScope, IGenreReleasesHolderFactory {
  @override
  IGenresNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  GenresSM get genresSM => _genresSM.get;

  @override
  GenresSM get genresRandomSM => _genresRandomSM.get;

  @override
  IGenresWM get genresWM => _genresWM.get;

  @override
  IGenresRandomWM get genresRandomWM => _genresRandomWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_navigationModule, _navigationController},
    {_genresSM, _genresRandomSM},
  ];

  GenresContainerScope({required super.data});

  /// {@macro genres_route}
  late final _route = dep<GenresRoute>(
    () => const GenresRoute(),
  );

  /// {@macro genres_navigation_module}
  late final _navigationModule = rawAsyncDep<GenresNavigationModule>(
    () => GenresNavigationModule(
      route: _route.get,
      genreReleasesHolderFactory: this,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// {@macro genres_remote_db}
  late final _remoteDB = dep(
    () => GenresRemoteDB(appNetwork: data.appNetwork),
  );

  /// {@macro genres_repository}
  late final _repository = dep(
    () => GenresRepository(remoteDB: _remoteDB.get),
  );

  /// {@macro genres_navigation_interactor}
  late final _navigationInteractor = dep(
    () => GenresNavigationInteractor(
      controller: _navigationController.get,
      route: _route.get,
    ),
  );

  /// {@macro yx_navigation_controller}
  late final _navigationController = rawAsyncDep(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro genres_sm}
  late final _genresSM = rawAsyncDep(
    () => GenresSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro genres_sm}
  late final _genresRandomSM = rawAsyncDep(
    () => GenresSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro genres_wm}
  late final _genresWM = dep(
    () => GenresWM(
      genresSM: _genresSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );

  /// {@macro genres_random_wm}
  late final _genresRandomWM = dep(
    () => GenresRandomWM(
      genresSM: _genresRandomSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );

  @override
  GenreReleasesContainerHolder create() => GenreReleasesContainerHolder();

  @override
  GenreReleasesContainerInputScope createInputScope({
    required int genreId,
  }) => GenreReleasesContainerInputScope(
    repository: _repository.get,
    genreId: genreId,
  );
}

/// {@template genres_container_holder}
/// Holder for Genres Container.
/// {@endtemplate}
class GenresContainerHolder
    extends
        BaseDataScopeHolder<
          GenresContainerOutputScope,
          GenresContainerScope,
          GenresContainerInputScope
        > {
  /// {@macro genres_container_holder}
  GenresContainerHolder();

  @override
  GenresContainerScope createContainer(
    GenresContainerInputScope data,
  ) => GenresContainerScope(data: data);
}
