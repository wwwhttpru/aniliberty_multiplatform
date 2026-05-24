import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/release/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template releases_container_input_scope}
/// Dependencies required from outside for Releases Container.
/// {@endtemplate}
@immutable
final class ReleasesContainerInputScope {
  /// App network for network operations.
  final AppNetwork appNetwork;

  /// Navigation container for creating navigation controller.
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for releases navigation.
  final RouteNodeResolver releasesRouteResolver;

  /// Route resolver for release navigation.
  final RouteNodeResolver releaseRouteResolver;

  /// Video player navigation interactor for opening episodes.
  final IVideoPlayerNavigationInteractor videoPlayerNavigationInteractor;

  /// {@macro releases_container_input_scope}
  const ReleasesContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.releasesRouteResolver,
    required this.releaseRouteResolver,
    required this.videoPlayerNavigationInteractor,
  });
}

/// {@template releases_container_output_scope}
/// Dependencies provided by Releases Container.
/// {@endtemplate}
abstract interface class ReleasesContainerOutputScope {
  /// State manager for release container lifecycle.
  abstract final ReleaseContainerSM releaseContainerSM;

  /// Remote data source for releases.
  abstract final IReleaseRemoteDB releaseRemoteDB;

  /// Release repository.
  abstract final IReleaseRepository releaseRepository;

  /// Releases navigation interactor.
  abstract final IReleasesNavigationInteractor navigationInteractor;

  /// State manager for latest releases.
  abstract final ReleasesSM releasesLatestSM;

  /// State manager for latest all releases.
  abstract final ReleasesSM releasesLatestAllSM;

  /// Widget model for latest releases.
  abstract final IReleasesLatestWM releasesLatestWM;

  /// Widget model for latest all releases.
  abstract final IReleasesLatestAllWM releasesLatestAllWM;
}

/// {@template releases_container_scope}
/// Scope for Releases Container.
/// {@endtemplate}
class ReleasesContainerScope
    extends DataScopeContainer<ReleasesContainerInputScope>
    implements ReleasesContainerOutputScope {
  @override
  ReleaseContainerSM get releaseContainerSM => _releaseContainerSM.get;

  @override
  IReleaseRemoteDB get releaseRemoteDB => _releaseRemoteDB.get;

  @override
  IReleaseRepository get releaseRepository => _releaseRepository.get;

  @override
  IReleasesNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  ReleasesSM get releasesLatestSM => _releasesLatestSM.get;

  @override
  ReleasesSM get releasesLatestAllSM => _releasesLatestAllSM.get;

  @override
  ReleasesLatestWM get releasesLatestWM => _releasesLatestWM.get;

  @override
  IReleasesLatestAllWM get releasesLatestAllWM => _releasesLatestAllWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {
      _releasesNavigationController,
      _releaseNavigationController,
      _navigationModule,
    },
    {_releaseContainerSM},
    {_releasesLatestSM, _releasesLatestAllSM},
  ];

  ReleasesContainerScope({required super.data});

  late final _route = dep<ReleaseRoute>(
    () => const ReleaseRoute(),
  );

  /// {@macro releases_navigation_module}
  late final _navigationModule = rawAsyncDep<ReleasesNavigationModule>(
    () => ReleasesNavigationModule(route: _route.get),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  late final _releaseContainerSM = rawAsyncDep(
    () => ReleaseContainerSM(
      route: _route.get,
      parent: this,
      nodeReadable: _releaseNavigationController.get,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.close(),
  );

  late final _releaseRemoteDB = dep(
    () => ReleaseRemoteDB(appNetwork: data.appNetwork),
  );

  late final _releaseRepository = dep(
    () => ReleaseRepository(remoteDB: _releaseRemoteDB.get),
  );

  late final _navigationInteractor = dep(
    () => ReleasesNavigationInteractor(
      releasesController: _releasesNavigationController.get,
      releaseController: _releaseNavigationController.get,
      playerNavigationInteractor: data.videoPlayerNavigationInteractor,
      route: _route.get,
    ),
  );

  late final _releasesNavigationController = rawAsyncDep(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.releasesRouteResolver,
    ),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _releaseNavigationController = rawAsyncDep(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.releaseRouteResolver,
    ),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _releasesLatestSM = rawAsyncDep(
    () => ReleasesSM(repository: _releaseRepository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _releasesLatestAllSM = rawAsyncDep(
    () => ReleasesSM(repository: _releaseRepository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _releasesLatestWM = dep(
    () => ReleasesLatestWM(
      releasesSM: _releasesLatestSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );

  late final _releasesLatestAllWM = dep(
    () => ReleasesLatestAllWM(releasesSM: _releasesLatestAllSM.get),
  );
}

/// {@template releases_container_holder}
/// Holder for Releases Container.
/// {@endtemplate}
class ReleasesContainerHolder
    extends
        BaseDataScopeHolder<
          ReleasesContainerOutputScope,
          ReleasesContainerScope,
          ReleasesContainerInputScope
        > {
  /// {@macro releases_container_holder}
  ReleasesContainerHolder();

  @override
  ReleasesContainerScope createContainer(
    ReleasesContainerInputScope data,
  ) => ReleasesContainerScope(data: data);
}
