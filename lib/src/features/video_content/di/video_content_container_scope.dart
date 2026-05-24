import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template video_content_container_input_scope}
/// Interface for input scope of Video Content Container
/// {@endtemplate}
@immutable
final class VideoContentContainerInputScope {
  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// {@macro video_content_container_input_scope}
  const VideoContentContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template video_content_container_output_scope}
/// Interface for output scope of Video Content Container
/// {@endtemplate}
abstract interface class VideoContentContainerOutputScope {
  /// Video content random state manager
  abstract final VideoContentSM videoContentRandomSM;

  /// Video content all state manager
  abstract final VideoContentSM videoContentAllSM;

  /// Video content all widget model
  abstract final IVideoContentAllWM videoContentAllWM;

  /// Video content random widget model
  abstract final IVideoContentRandomWM videoContentRandomWM;
}

/// {@template video_content_container_scope}
/// Scope for Video Content Container
/// {@endtemplate}
class VideoContentContainerScope
    extends DataScopeContainer<VideoContentContainerInputScope>
    implements VideoContentContainerOutputScope {
  @override
  VideoContentSM get videoContentRandomSM => _videoContentRandomSM.get;

  @override
  VideoContentSM get videoContentAllSM => _videoContentAllSM.get;

  @override
  IVideoContentAllWM get videoContentAllWM => _videoContentAllWM.get;

  @override
  IVideoContentRandomWM get videoContentRandomWM => _videoContentRandomWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {
      _controller,
      _navigationModule,
      _urlLauncher,
      _videoContentRandomSM,
      _videoContentAllSM,
    },
  ];

  VideoContentContainerScope({required super.data});

  /// {@macro i_video_content_remote_db}
  late final _remoteDB = dep<IVideoContentRemoteDB>(
    () => VideoContentRemoteDB(appNetwork: data.appNetwork),
  );

  /// {@macro i_video_content_repository}
  late final _repository = dep<IVideoContentRepository>(
    () => VideoContentRepository(remoteDB: _remoteDB.get),
  );

  /// {@macro video_content_sm}
  late final _videoContentRandomSM = rawAsyncDep<VideoContentSM>(
    () => VideoContentSM(repository: _repository.get),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro video_content_sm}
  late final _videoContentAllSM = rawAsyncDep<VideoContentSM>(
    () => VideoContentSM(repository: _repository.get),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro video_content_route}
  late final _videoContentRoute = dep<VideoContentRoute>(
    () => const VideoContentRoute(),
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _urlLauncher = rawAsyncDep<UrlLauncherStateManager>(
    UrlLauncherStateManager.new,
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro i_video_content_navigation_interactor}
  late final _navigationInteractor = dep<IVideoContentNavigationInteractor>(
    () => VideoContentNavigationInteractor(
      route: _videoContentRoute.get,
      controller: _controller.get,
    ),
  );

  /// {@macro video_content_navigation_module}
  late final _navigationModule = rawAsyncDep<VideoContentNavigationModule>(
    () => VideoContentNavigationModule(
      route: _videoContentRoute.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// Video content all widget model
  late final _videoContentAllWM = dep<IVideoContentAllWM>(
    () => VideoContentAllWM(
      videoContentAllSM: _videoContentAllSM.get,
      navigationInteractor: _navigationInteractor.get,
      urlLauncher: _urlLauncher.get,
    ),
  );

  /// Video content random widget model
  late final _videoContentRandomWM = dep<IVideoContentRandomWM>(
    () => VideoContentRandomWM(
      videoContentRandomSM: _videoContentRandomSM.get,
      navigationInteractor: _navigationInteractor.get,
      urlLauncher: _urlLauncher.get,
    ),
  );
}

/// {@template video_content_container_holder}
/// Holder for Video Content Container
/// {@endtemplate}
class VideoContentContainerHolder
    extends
        BaseDataScopeHolder<
          VideoContentContainerOutputScope,
          VideoContentContainerScope,
          VideoContentContainerInputScope
        > {
  /// {@macro video_content_container_holder}
  VideoContentContainerHolder();

  @override
  VideoContentContainerScope createContainer(
    VideoContentContainerInputScope data,
  ) => VideoContentContainerScope(data: data);
}
