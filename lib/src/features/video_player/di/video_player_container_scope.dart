import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/di/episode_container_scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/router/router.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

abstract interface class VideoPlayerContainerOutputScope {
  ///
  /// * Domain *
  ///

  abstract final IVideoPlayerNavigationInteractor navigationInteractor;
}

@immutable
class VideoPlayerContainerInputScope {
  /// Сеть
  final AppNetwork appNetwork;

  /// Settings repository
  final SettingVideoQualitySM videoQualitySM;

  /// Требуется для создания NavigationController
  final ModuleNavigationContainer navigationContainer;

  /// Резолвер для создания NavigationController
  final RouteNodeResolver routeResolver;

  const VideoPlayerContainerInputScope({
    required this.appNetwork,
    required this.videoQualitySM,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

class VideoPlayerContainerScope
    extends DataScopeContainer<VideoPlayerContainerInputScope>
    implements VideoPlayerContainerOutputScope, EpisodeContainerInputFactory {
  @override
  IVideoPlayerNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_controller, _episodeNodeSource},
    {_episodeContainerSM},
    {_navigationModule},
  ];

  VideoPlayerContainerScope({required super.data});

  late final _remoteDB = dep<IVideoPlayerRemoteDB>(
    () => VideoPlayerRemoteDB(appNetwork: data.appNetwork),
  );

  late final _localDB = dep<IVideoPlayerLocalDB>(
    () => VideoPlayerLocalDB(
      qualitySM: data.videoQualitySM,
    ),
  );

  late final _repository = dep<IVideoPlayerRepository>(
    () => VideoPlayerRepository(
      remoteDB: _remoteDB.get,
      localDB: _localDB.get,
      converter: const PlayerConverter(),
    ),
  );

  late final _route = dep<VideoPlayerRoute>(
    () => const VideoPlayerRoute(),
  );

  late final _navigationModule = rawAsyncDep<VideoPlayerNavigationModule>(
    () => VideoPlayerNavigationModule(
      route: _route.get,
      episodeContainerSM: _episodeContainerSM.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _navigationInteractor = dep<IVideoPlayerNavigationInteractor>(
    () => VideoPlayerNavigationInteractor(
      route: _route.get,
      controller: _controller.get,
    ),
  );

  late final _episodeNodeSource = rawAsyncDep<EpisodeNodeSource>(
    () => EpisodeNodeSource(
      nodeReadable: data.navigationContainer.navigationController,
      route: _route.get,
      inputFactory: this,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  late final _episodeContainerSM = rawAsyncDep<EpisodeContainerSM>(
    () => EpisodeContainerSM(episodeNodeSource: _episodeNodeSource.get),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  @protected
  @override
  EpisodeContainerInputScope create(
    String episodeId,
  ) => EpisodeContainerInputScope(
    appNetwork: data.appNetwork,
    repository: _repository.get,
    episodeId: episodeId,
    navigationInteractor: _navigationInteractor.get,
  );
}

class VideoPlayerContainerHolder
    extends
        BaseDataScopeHolder<
          VideoPlayerContainerOutputScope,
          VideoPlayerContainerScope,
          VideoPlayerContainerInputScope
        > {
  VideoPlayerContainerHolder();

  @override
  VideoPlayerContainerScope createContainer(
    VideoPlayerContainerInputScope data,
  ) => VideoPlayerContainerScope(data: data);
}
