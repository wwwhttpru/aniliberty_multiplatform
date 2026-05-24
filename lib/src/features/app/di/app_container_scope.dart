import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/features.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_container_input_scope}
/// Interface for input scope of App Container
/// {@endtemplate}
@immutable
final class AppContainerInputScope {
  /// {@macro logger}
  final Logger logger;

  /// {@macro app_container_input_scope}
  const AppContainerInputScope({required this.logger});
}

abstract interface class AppContainerOutputScope {
  abstract final AppConfig appConfig;
  abstract final AppNetwork appNetwork;
  abstract final IAppDatabase appDatabase;
  abstract final NavigationContainerOutputScope navigationScope;

  // Children
  abstract final AppStatusContainerHolder appStatusContainerHolder;
  abstract final AuthContainerHolder authContainerHolder;
  abstract final SettingsContainerHolder settingsContainerHolder;
  abstract final TabBarContainerHolder tabBarContainerHolder;
  abstract final MoreContainerHolder moreContainerHolder;
  abstract final PromotionsContainerHolder promotionsContainerHolder;
  abstract final GenresContainerHolder genresContainerHolder;
  abstract final CatalogContainerHolder catalogContainerHolder;
  abstract final ReleasesContainerHolder releasesContainerHolder;
  abstract final FranchisesContainerHolder franchisesContainerHolder;
  abstract final VideoContentContainerHolder videoContentContainerHolder;
  abstract final ScheduleContainerHolder scheduleContainerHolder;
  abstract final FeedContainerHolder feedContainerHolder;
  abstract final SearchContainerHolder searchContainerHolder;
  abstract final VideoPlayerContainerHolder videoPlayerContainerHolder;
}

class AppContainerScope extends DataScopeContainer<AppContainerInputScope>
    implements AppContainerOutputScope {
  @override
  AppConfig get appConfig => _appConfig.get;

  @override
  AppNetwork get appNetwork => _appNetwork.get;

  @override
  IAppDatabase get appDatabase => _appDatabase.get;

  @override
  NavigationContainerOutputScope get navigationScope {
    final scope = _navigationContainerHolder.get.scope;
    return ArgumentError.checkNotNull(scope, 'navigationScope');
  }

  @override
  AppStatusContainerHolder get appStatusContainerHolder =>
      _appStatusContainerHolder.get;

  @override
  AuthContainerHolder get authContainerHolder => _authContainerHolder.get;

  @override
  SettingsContainerHolder get settingsContainerHolder =>
      _settingsContainerHolder.get;

  @override
  TabBarContainerHolder get tabBarContainerHolder => _tabBarContainerHolder.get;

  @override
  MoreContainerHolder get moreContainerHolder => _moreContainerHolder.get;

  @override
  PromotionsContainerHolder get promotionsContainerHolder =>
      _promotionsContainerHolder.get;

  @override
  GenresContainerHolder get genresContainerHolder => _genresContainerHolder.get;

  @override
  CatalogContainerHolder get catalogContainerHolder =>
      _catalogContainerHolder.get;

  @override
  ReleasesContainerHolder get releasesContainerHolder =>
      _releasesContainerHolder.get;

  @override
  FranchisesContainerHolder get franchisesContainerHolder =>
      _franchisesContainerHolder.get;

  @override
  VideoContentContainerHolder get videoContentContainerHolder =>
      _videoContentContainerHolder.get;

  @override
  ScheduleContainerHolder get scheduleContainerHolder =>
      _scheduleContainerHolder.get;

  @override
  FeedContainerHolder get feedContainerHolder => _feedContainerHolder.get;

  @override
  SearchContainerHolder get searchContainerHolder => _searchContainerHolder.get;

  @override
  VideoPlayerContainerHolder get videoPlayerContainerHolder =>
      _videoPlayerContainerHolder.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_loggerInteractor, _stateManagerLogger},
    {_apiUrlInteractor},
    {_appNetwork, _appDatabase, _navigationContainerHolder},
    {
      _tabBarContainerHolder,
      _appStatusContainerHolder,
      _authContainerHolder,
      _settingsContainerHolder,
      _feedContainerHolder,
    },
    {_videoPlayerContainerHolder, _moreContainerHolder},
    {_releasesContainerHolder},
    {
      _promotionsContainerHolder,
      _genresContainerHolder,
      _catalogContainerHolder,
      _franchisesContainerHolder,
      _videoContentContainerHolder,
      _scheduleContainerHolder,
      _searchContainerHolder,
    },
  ];

  AppContainerScope({required super.data});

  // ================================================
  // Core start
  // ================================================

  /// {@macro logger_interactor}
  late final _loggerInteractor = rawAsyncDep<LoggerInteractor>(
    () => LoggerInteractor(
      logger: data.logger,
      listeners: const [DeveloperLoggerListener()],
    ),
    init: (value) => value.initialize(),
    dispose: (value) => value.close(),
  );

  /// {@macro state_manager_logger}
  late final _stateManagerLogger = rawAsyncDep<StateManagerLogger>(
    () => StateManagerLogger(logger: data.logger),
    init: (value) => value.initialize(),
    dispose: (value) => value.close(),
  );

  /// {@macro app_config}
  late final _appConfig = dep<AppConfig>(
    () => const AppConfigImpl(urlConfig: AppUrlConfigImpl()),
  );

  /// {@macro api_url_interactor}
  late final _apiUrlInteractor = rawAsyncDep<ApiUrlInteractor>(
    () => ApiUrlInteractor(
      logger: data.logger,
      appUrlConfig: _appConfig.get.urlConfig,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  /// {@macro app_network}
  late final _appNetwork = rawAsyncDep(
    () => AppNetworkImpl(
      logger: data.logger,
      apiUrlInteractor: _apiUrlInteractor.get,
    ),
    init: (value) => value.initialize(),
    dispose: (value) => value.dispose(),
  );

  /// {@macro app_database}
  late final _appDatabase = rawAsyncDep(
    AppDatabase.new,
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  // ================================================
  // Core end
  // ================================================

  // ================================================
  // Navigation start
  // ================================================

  /// {@macro app_route}
  late final _appRoute = dep<AppRoute>(
    () => const AppRoute(),
  );

  /// {@macro app_navigation_module}
  late final _appNavigationModule = dep<AppNavigationModule>(
    () => const AppNavigationModule(),
  );

  /// {@macro navigation_input_scope}
  late final _navigationInputScope = dep<NavigationContainerInputScope>(
    () => NavigationContainerInputScope(
      rootRoute: _appRoute.get.root,
      hostNavigationModule: _appNavigationModule.get,
    ),
  );

  /// {@macro navigation_container_holder}
  late final _navigationContainerHolder = rawAsyncDep(
    NavigationContainerHolder.new,
    init: (value) => value.create(_navigationInputScope.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // Navigation end
  // ================================================

  // ================================================
  // TabBar start
  // ================================================

  /// {@macro tab_bar_container_input_scope}
  late final _tabBarContainerInput = dep(
    () => TabBarContainerInputScope(
      tabBarRoute: TabBarRoute(
        parentRoute: _appRoute.get.root,
        tab: _appRoute.get.tabBar,
        feedTab: _appRoute.get.feedTab,
        catalogTab: _appRoute.get.catalogTab,
        moreTab: _appRoute.get.moreTab,
      ),
      navigationContainer: navigationScope.moduleNavigationContainer,
    ),
  );

  /// {@macro tab_bar_container_holder}
  late final _tabBarContainerHolder = rawAsyncDep(
    TabBarContainerHolder.new,
    init: (value) => value.create(_tabBarContainerInput.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // TabBar end
  // ================================================

  // ================================================
  // App Status start
  // ================================================

  /// {@macro app_status_container_input_scope}
  late final _appStatusContainerInput = dep(
    () => AppStatusContainerInputScope(
      appNetwork: appNetwork,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.moreTab),
    ),
  );

  /// {@macro app_status_container_holder}
  late final _appStatusContainerHolder = rawAsyncDep(
    AppStatusContainerHolder.new,
    init: (value) => value.create(_appStatusContainerInput.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // App Status end
  // ================================================

  // ================================================
  // Auth start
  // ================================================

  /// {@macro auth_container_input_scope}
  late final _authContainerInput = dep(
    () => AuthContainerInputScope(
      appUrlConfig: appConfig.urlConfig,
      appNetwork: appNetwork,
      appDatabase: appDatabase,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.root),
    ),
  );

  /// {@macro auth_container_holder}
  late final _authContainerHolder = rawAsyncDep(
    AuthContainerHolder.new,
    init: (value) => value.create(_authContainerInput.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // Auth end
  // ================================================

  // ================================================
  // Settings start
  // ================================================

  /// {@macro settings_container_input_scope}
  late final _settingsContainerInput = dep(
    () => SettingsContainerInputScope(
      appDatabase: appDatabase,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.moreTab),
    ),
  );

  /// {@macro settings_container_holder}
  late final _settingsContainerHolder = rawAsyncDep(
    SettingsContainerHolder.new,
    init: (value) => value.create(_settingsContainerInput.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // Settings end
  // ================================================

  // ================================================
  // Franchises start
  // ================================================

  late final _franchisesContainerInput = dep(
    () => FranchisesContainerInputScope(
      appNetwork: appNetwork,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.feedTab),
    ),
  );

  late final _franchisesContainerHolder = rawAsyncDep(
    FranchisesContainerHolder.new,
    init: (value) => value.create(_franchisesContainerInput.get),
    dispose: (value) => value.drop(),
  );

  // ================================================
  // Franchises end
  // ================================================

  late final _moreContainerInput = dep(
    () {
      final auth = _authContainerHolder.get.scope;
      if (auth == null) {
        throw Exception('Auth feature is not initialized');
      }

      final settings = _settingsContainerHolder.get.scope;
      if (settings == null) {
        throw Exception('Settings feature is not initialized');
      }

      final appStatus = _appStatusContainerHolder.get.scope;
      if (appStatus == null) {
        throw Exception('App Status feature is not initialized');
      }

      return MoreContainerInputScope(
        appUrlConfig: appConfig.urlConfig,
        moreRoute: MoreRoute(moreTab: _appRoute.get.moreTab),
        navigationContainer: navigationScope.moduleNavigationContainer,
        routeResolver: RouteNodeResolver.id(route: _appRoute.get.root),
        authNavigationInteractor: auth.navigationInteractor,
        settingsNavigationInteractor: settings.navigationInteractor,
        appStatusNavigationInteractor: appStatus.appStatusNavigationInteractor,
      );
    },
  );

  late final _moreContainerHolder = rawAsyncDep(
    MoreContainerHolder.new,
    init: (value) => value.create(_moreContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _promotionsContainerInput = dep(
    () => PromotionsContainerInputScope(
      appNetwork: appNetwork,
    ),
  );

  late final _promotionsContainerHolder = rawAsyncDep(
    PromotionsContainerHolder.new,
    init: (value) => value.create(_promotionsContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _genresContainerInput = dep(
    () => GenresContainerInputScope(
      appNetwork: appNetwork,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.feedTab),
    ),
  );

  late final _genresContainerHolder = rawAsyncDep(
    GenresContainerHolder.new,
    init: (value) => value.create(_genresContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _catalogContainerInput = dep(
    () {
      final releases = _releasesContainerHolder.get.scope;
      if (releases == null) {
        throw Exception('Releases feature is not initialized');
      }

      return CatalogContainerInputScope(
        appNetwork: appNetwork,
        catalogRoute: CatalogRoute(catalogTab: _appRoute.get.catalogTab),
        navigationContainer: navigationScope.moduleNavigationContainer,
        releasesNavigationInteractor: releases.navigationInteractor,
        routeResolver: RouteNodeResolver.id(route: _appRoute.get.catalogTab),
      );
    },
  );

  late final _catalogContainerHolder = rawAsyncDep(
    CatalogContainerHolder.new,
    init: (value) => value.create(_catalogContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _releasesContainerInput = dep(
    () {
      final videoPlayer = _videoPlayerContainerHolder.get.scope;
      if (videoPlayer == null) {
        throw Exception('Video Player feature is not initialized');
      }

      return ReleasesContainerInputScope(
        appNetwork: appNetwork,
        navigationContainer: navigationScope.moduleNavigationContainer,
        videoPlayerNavigationInteractor: videoPlayer.navigationInteractor,
        releasesRouteResolver: RouteNodeResolver.id(
          route: _appRoute.get.feedTab,
        ),
        releaseRouteResolver: RouteNodeResolver.id(route: _appRoute.get.root),
      );
    },
  );

  late final _releasesContainerHolder = rawAsyncDep(
    ReleasesContainerHolder.new,
    init: (value) => value.create(_releasesContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _videoContentContainerInput = dep(
    () => VideoContentContainerInputScope(
      appNetwork: appNetwork,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.root),
    ),
  );

  late final _videoContentContainerHolder = rawAsyncDep(
    VideoContentContainerHolder.new,
    init: (value) => value.create(_videoContentContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _scheduleContainerInput = dep(
    () => ScheduleContainerInputScope(
      appNetwork: appNetwork,
      navigationContainer: navigationScope.moduleNavigationContainer,
      routeResolver: RouteNodeResolver.id(route: _appRoute.get.feedTab),
    ),
  );

  late final _scheduleContainerHolder = rawAsyncDep(
    ScheduleContainerHolder.new,
    init: (value) => value.create(_scheduleContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _feedContainerInput = dep(
    () => FeedContainerInputScope(
      feedRoute: FeedRoute(feedTab: _appRoute.get.feedTab),
      navigationContainer: navigationScope.moduleNavigationContainer,
    ),
  );

  late final _feedContainerHolder = rawAsyncDep(
    FeedContainerHolder.new,
    init: (value) => value.create(_feedContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _searchContainerInput = dep(
    () {
      final releases = _releasesContainerHolder.get.scope;
      if (releases == null) {
        throw Exception('Releases feature is not initialized');
      }

      return SearchContainerInputScope(
        appNetwork: appNetwork,
        navigationContainer: navigationScope.moduleNavigationContainer,
        routeResolver: RouteNodeResolver.id(route: _appRoute.get.root),
        releasesNavigationInteractor: releases.navigationInteractor,
      );
    },
  );

  late final _searchContainerHolder = rawAsyncDep(
    SearchContainerHolder.new,
    init: (value) => value.create(_searchContainerInput.get),
    dispose: (value) => value.drop(),
  );

  late final _videoPlayerInput = dep(
    () {
      final settings = _settingsContainerHolder.get.scope;
      if (settings == null) {
        throw Exception('Settings feature is not initialized');
      }

      return VideoPlayerContainerInputScope(
        appNetwork: appNetwork,
        videoQualitySM: settings.videoQualitySM,
        navigationContainer: navigationScope.moduleNavigationContainer,
        routeResolver: RouteNodeResolver.id(route: _appRoute.get.root),
      );
    },
  );

  late final _videoPlayerContainerHolder = rawAsyncDep(
    VideoPlayerContainerHolder.new,
    init: (value) => value.create(_videoPlayerInput.get),
    dispose: (value) => value.drop(),
  );
}

/// {@template app_container_holder}
/// Holder for App Container
/// {@endtemplate}
class AppContainerHolder
    extends
        BaseDataScopeHolder<
          AppContainerOutputScope,
          AppContainerScope,
          AppContainerInputScope
        > {
  /// {@macro app_container_holder}
  AppContainerHolder();

  @override
  AppContainerScope createContainer(
    AppContainerInputScope data,
  ) => AppContainerScope(data: data);
}
