import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/app_status.dart';
import 'package:aniliberty_multiplatform/src/features/auth/auth.dart';
import 'package:aniliberty_multiplatform/src/features/more/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/more/widget/widget.dart';
import 'package:aniliberty_multiplatform/src/features/settings/settings.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template more_container_input_scope}
/// Interface for input scope of More Container
/// {@endtemplate}
@immutable
final class MoreContainerInputScope {
  /// App url config
  final AppUrlConfig appUrlConfig;

  /// {@macro more_route}
  final MoreRoute moreRoute;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// Auth navigation interactor
  final IAuthNavigationInteractor authNavigationInteractor;

  /// Settings navigation interactor
  final ISettingsNavigationInteractor settingsNavigationInteractor;

  /// App status navigation interactor
  final IAppStatusNavigationInteractor appStatusNavigationInteractor;

  /// {@macro more_container_input_scope}
  const MoreContainerInputScope({
    required this.appUrlConfig,
    required this.moreRoute,
    required this.navigationContainer,
    required this.routeResolver,
    required this.authNavigationInteractor,
    required this.settingsNavigationInteractor,
    required this.appStatusNavigationInteractor,
  });
}

/// {@template more_container_output_scope}
/// Interface for output scope of More Container
/// {@endtemplate}
abstract interface class MoreContainerOutputScope {
  /// {@macro more_route}
  abstract final MoreRoute moreRoute;

  /// {@macro more_wm}
  abstract final IMoreWM moreWM;
}

/// {@template more_container_scope}
/// Scope for More Container
/// {@endtemplate}
class MoreContainerScope extends DataScopeContainer<MoreContainerInputScope>
    implements MoreContainerOutputScope {
  @override
  MoreRoute get moreRoute => _route.get;

  @override
  IMoreWM get moreWM => _moreWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_controller},
    {_navigationModule, _urlLauncher},
  ];

  MoreContainerScope({required super.data});

  /// {@macro more_route}
  late final _route = dep<MoreRoute>(
    () => data.moreRoute,
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro url_launcher}
  late final _urlLauncher = rawAsyncDep<UrlLauncherStateManager>(
    UrlLauncherStateManager.new,
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro more_wm}
  late final _moreWM = dep<IMoreWM>(
    () => MoreWM(
      authNavigationInteractor: data.authNavigationInteractor,
      settingsNavigationInteractor: data.settingsNavigationInteractor,
      appStatusNavigationInteractor: data.appStatusNavigationInteractor,
      appUrlConfig: data.appUrlConfig,
      urlLauncher: _urlLauncher.get,
    ),
  );

  /// {@macro more_navigation_module}
  late final _navigationModule = rawAsyncDep<MoreNavigationModule>(
    () => MoreNavigationModule(
      route: _route.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );
}

/// {@template more_container_holder}
/// Holder for More Container
/// {@endtemplate}
class MoreContainerHolder
    extends
        BaseDataScopeHolder<
          MoreContainerOutputScope,
          MoreContainerScope,
          MoreContainerInputScope
        > {
  /// {@macro more_container_holder}
  MoreContainerHolder();

  @override
  MoreContainerScope createContainer(
    MoreContainerInputScope data,
  ) => MoreContainerScope(data: data);
}
