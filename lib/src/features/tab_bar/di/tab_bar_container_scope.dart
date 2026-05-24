import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/tab_bar/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template tab_bar_container_input_scope}
/// Interface for input scope of TabBar Container
/// {@endtemplate}
@immutable
final class TabBarContainerInputScope {
  /// {@macro tab_bar_route}
  final TabBarRoute tabBarRoute;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// {@macro tab_bar_container_input_scope}
  const TabBarContainerInputScope({
    required this.tabBarRoute,
    required this.navigationContainer,
  });
}

/// {@template tab_bar_container_output_scope}
/// Interface for output scope of TabBar Container
/// {@endtemplate}
abstract interface class TabBarContainerOutputScope {
  /// {@macro tab_bar_sm}
  abstract final TabBarSM tabBarSM;

  /// {@macro tab_bar_navigation_interactor}
  abstract final ITabBarNavigationInteractor navigationInteractor;

  /// {@macro tab_bar_wm}
  abstract final ITabBarWM tabBarWM;
}

/// {@template tab_bar_container_scope}
/// Scope for TabBar Container
/// {@endtemplate}
class TabBarContainerScope extends DataScopeContainer<TabBarContainerInputScope>
    implements TabBarContainerOutputScope {
  @override
  TabBarSM get tabBarSM => _tabBarSM.get;

  @override
  ITabBarNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  ITabBarWM get tabBarWM => _tabBarWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_controller},
    {_navigationModule},
  ];

  TabBarContainerScope({required super.data});

  /// {@macro tab_bar_route}
  TabBarRoute get _route => data.tabBarRoute;

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: RouteNodeResolver.id(route: _route.tab),
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro tab_bar_navigation_module}
  late final _navigationModule = rawAsyncDep<TabBarNavigationModule>(
    () => TabBarNavigationModule(route: _route),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// {@macro tab_bar_navigation_interactor}
  late final _navigationInteractor = dep<TabBarNavigationInteractor>(
    () => TabBarNavigationInteractor(
      route: _route,
      controller: _controller.get,
    ),
  );

  /// {@macro tab_bar_sm}
  late final _tabBarSM = dep<TabBarSM>(
    () => TabBarSM(
      routeIndexedNavigator: _controller.get,
      route: _route,
    ),
  );

  /// {@macro tab_bar_wm}
  late final _tabBarWM = dep<TabBarWM>(
    () => TabBarWM(
      tabBarSM: _tabBarSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );
}

/// {@template tab_bar_container_holder}
/// Holder for TabBar Container
/// {@endtemplate}
class TabBarContainerHolder
    extends
        BaseDataScopeHolder<
          TabBarContainerOutputScope,
          TabBarContainerScope,
          TabBarContainerInputScope
        > {
  /// {@macro tab_bar_container_holder}
  TabBarContainerHolder();

  @override
  TabBarContainerScope createContainer(
    TabBarContainerInputScope data,
  ) => TabBarContainerScope(data: data);
}
