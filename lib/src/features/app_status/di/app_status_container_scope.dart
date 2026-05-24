import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template app_status_container_input_scope}
/// Interface for input scope of App Status Container
/// {@endtemplate}
@immutable
final class AppStatusContainerInputScope {
  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// {@macro app_status_container_input_scope}
  const AppStatusContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template app_status_container_output_scope}
/// Interface for output scope of App Status Container
/// {@endtemplate}
abstract interface class AppStatusContainerOutputScope {
  /// App status state manager
  abstract final AppStatusSM appStatusSM;

  /// App status widget model
  abstract final IAppStatusWM appStatusWM;

  /// App status navigation interactor
  abstract final IAppStatusNavigationInteractor appStatusNavigationInteractor;
}

/// {@template app_status_container_scope}
/// Scope for App Status Container
/// {@endtemplate}
class AppStatusContainerScope
    extends DataScopeContainer<AppStatusContainerInputScope>
    implements AppStatusContainerOutputScope {
  @override
  AppStatusSM get appStatusSM => _appStatusSM.get;

  @override
  IAppStatusWM get appStatusWM => _appStatusWM.get;

  @override
  IAppStatusNavigationInteractor get appStatusNavigationInteractor =>
      _navigationInteractor.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_controller, _appStatusSM},
    {_navigationModule},
  ];

  AppStatusContainerScope({required super.data});

  /// {@macro i_app_status_remote_db}
  late final _remoteDB = dep<IAppStatusRemoteDB>(
    () => AppStatusRemoteDB(
      appNetwork: data.appNetwork,
    ),
  );

  /// {@macro i_app_status_repository}
  late final _repository = dep<IAppStatusRepository>(
    () => AppStatusRepository(
      remoteDB: _remoteDB.get,
    ),
  );

  /// {@macro app_status_sm}
  late final _appStatusSM = rawAsyncDep<AppStatusSM>(
    () => AppStatusSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro app_status_wm}
  late final _appStatusWM = dep<IAppStatusWM>(
    () => AppStatusWM(appStatusSM: _appStatusSM.get),
  );

  /// {@macro app_status_route}
  late final _route = dep<AppStatusRoute>(
    () => const AppStatusRoute(),
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro app_status_navigation_interactor}
  late final _navigationInteractor = dep<IAppStatusNavigationInteractor>(
    () => AppStatusNavigationInteractor(
      route: _route.get,
      controller: _controller.get,
    ),
  );

  /// {@macro app_status_navigation_module}
  late final _navigationModule = rawAsyncDep<AppStatusNavigationModule>(
    () => AppStatusNavigationModule(
      route: _route.get,
      container: this,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );
}

/// {@template app_status_container_holder}
/// Holder for App Status Container
/// {@endtemplate}
class AppStatusContainerHolder
    extends
        BaseDataScopeHolder<
          AppStatusContainerOutputScope,
          AppStatusContainerScope,
          AppStatusContainerInputScope
        > {
  /// {@macro app_status_container_holder}
  AppStatusContainerHolder();

  @override
  AppStatusContainerScope createContainer(
    AppStatusContainerInputScope data,
  ) => AppStatusContainerScope(data: data);
}
