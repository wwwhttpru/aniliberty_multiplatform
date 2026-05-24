import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:aniliberty_multiplatform/src/features/search/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/search/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template search_container_input_scope}
/// Interface for input scope of Search Container
/// {@endtemplate}
@immutable
final class SearchContainerInputScope {
  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// Releases navigation interactor
  final IReleasesNavigationInteractor releasesNavigationInteractor;

  /// {@macro search_container_input_scope}
  const SearchContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
    required this.releasesNavigationInteractor,
  });
}

/// {@template search_container_output_scope}
/// Interface for output scope of Search Container
/// {@endtemplate}
abstract interface class SearchContainerOutputScope {
  /// Anime search state manager
  abstract final AnimeSearchSM animeSearchSM;

  /// Anime search widget model
  abstract final IAnimeSearchWM animeSearchWM;
}

/// {@template search_container_scope}
/// Scope for Search Container
/// {@endtemplate}
class SearchContainerScope extends DataScopeContainer<SearchContainerInputScope>
    implements SearchContainerOutputScope {
  @override
  AnimeSearchSM get animeSearchSM => _animeSearchSM.get;

  @override
  IAnimeSearchWM get animeSearchWM => _animeSearchWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_controller, _animeSearchSM, _navigationModule},
    {_animeSearchWM},
  ];

  SearchContainerScope({required super.data});

  /// {@macro i_search_remote_db}
  late final _remoteDB = dep<ISearchRemoteDB>(
    () => SearchRemoteDB(appNetwork: data.appNetwork),
  );

  /// {@macro i_search_repository}
  late final _repository = dep<ISearchRepository>(
    () => SearchRepository(remoteDB: _remoteDB.get),
  );

  /// {@macro anime_search_sm}
  late final _animeSearchSM = rawAsyncDep<AnimeSearchSM>(
    () => AnimeSearchSM(repository: _repository.get),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro search_route}
  late final _searchRoute = dep<SearchRoute>(
    () => const SearchRoute(),
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro i_search_navigation_interactor}
  late final _navigationInteractor = dep<ISearchNavigationInteractor>(
    () => SearchNavigationInteractor(
      route: _searchRoute.get,
      controller: _controller.get,
    ),
  );

  /// {@macro search_navigation_module}
  late final _navigationModule = rawAsyncDep<SearchNavigationModule>(
    () => SearchNavigationModule(
      route: _searchRoute.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// Anime search widget model
  late final _animeSearchWM = rawAsyncDep<AnimeSearchWM>(
    () => AnimeSearchWM(
      animeSearchSM: _animeSearchSM.get,
      searchNavigationInteractor: _navigationInteractor.get,
      releasesNavigationInteractor: data.releasesNavigationInteractor,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );
}

/// {@template search_container_holder}
/// Holder for Search Container
/// {@endtemplate}
class SearchContainerHolder
    extends
        BaseDataScopeHolder<
          SearchContainerOutputScope,
          SearchContainerScope,
          SearchContainerInputScope
        > {
  /// {@macro search_container_holder}
  SearchContainerHolder();

  @override
  SearchContainerScope createContainer(
    SearchContainerInputScope data,
  ) => SearchContainerScope(data: data);
}
