import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/schedule/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template schedule_container_input_scope}
/// Dependencies required from outside for Schedule Container.
/// {@endtemplate}
@immutable
final class ScheduleContainerInputScope {
  /// App network for network operations.
  final AppNetwork appNetwork;

  /// Navigation container for creating navigation controller.
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for feed tab navigation.
  final RouteNodeResolver routeResolver;

  /// {@macro schedule_container_input_scope}
  const ScheduleContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template schedule_container_output_scope}
/// Dependencies provided by Schedule Container.
/// {@endtemplate}
abstract interface class ScheduleContainerOutputScope {
  /// Remote data source for schedule.
  abstract final IScheduleRemoteDB remoteDB;

  /// Schedule repository.
  abstract final IScheduleRepository repository;

  /// Schedule navigation interactor.
  abstract final IScheduleNavigationInteractor navigationInteractor;

  /// State manager for schedule now.
  abstract final ScheduleNowSM scheduleNowSM;

  /// State manager for schedule week.
  abstract final ScheduleWeekSM scheduleWeekSM;

  /// Widget model for schedule now.
  abstract final IScheduleNowWM scheduleNowWM;

  /// Widget model for schedule week.
  abstract final IScheduleWeekWM scheduleWeekWM;
}

/// {@template schedule_container_scope}
/// Scope for Schedule Container.
/// {@endtemplate}
class ScheduleContainerScope
    extends DataScopeContainer<ScheduleContainerInputScope>
    implements ScheduleContainerOutputScope {
  @override
  IScheduleRemoteDB get remoteDB => _remoteDB.get;

  @override
  IScheduleRepository get repository => _repository.get;

  @override
  IScheduleNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  ScheduleNowSM get scheduleNowSM => _scheduleNowSM.get;

  @override
  ScheduleWeekSM get scheduleWeekSM => _scheduleWeekSM.get;

  @override
  IScheduleNowWM get scheduleNowWM => _scheduleNowWM.get;

  @override
  IScheduleWeekWM get scheduleWeekWM => _scheduleWeekWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_navigationModule, _navigationController},
    {_scheduleNowSM, _scheduleWeekSM},
  ];

  ScheduleContainerScope({required super.data});

  late final _route = dep<ScheduleRoute>(
    () => const ScheduleRoute(),
  );

  /// {@macro schedule_navigation_module}
  late final _navigationModule = rawAsyncDep<ScheduleNavigationModule>(
    () => ScheduleNavigationModule(route: _route.get),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  late final _remoteDB = dep(
    () => ScheduleRemoteDB(appNetwork: data.appNetwork),
  );

  late final _repository = dep(
    () => ScheduleRepository(remoteDB: _remoteDB.get),
  );

  late final _navigationInteractor = dep(
    () => ScheduleNavigationInteractor(
      controller: _navigationController.get,
      route: _route.get,
    ),
  );

  late final _navigationController = rawAsyncDep(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _scheduleNowSM = rawAsyncDep(
    () => ScheduleNowSM(repository: _repository.get),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _scheduleWeekSM = rawAsyncDep(
    () => ScheduleWeekSM(repository: _repository.get),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _scheduleNowWM = dep(
    () => ScheduleNowWM(
      scheduleNowSM: _scheduleNowSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );

  late final _scheduleWeekWM = dep(
    () => ScheduleWeekWM(scheduleWeekSM: _scheduleWeekSM.get),
  );
}

/// {@template schedule_container_holder}
/// Holder for Schedule Container.
/// {@endtemplate}
class ScheduleContainerHolder
    extends
        BaseDataScopeHolder<
          ScheduleContainerOutputScope,
          ScheduleContainerScope,
          ScheduleContainerInputScope
        > {
  /// {@macro schedule_container_holder}
  ScheduleContainerHolder();

  @override
  ScheduleContainerScope createContainer(ScheduleContainerInputScope data) =>
      ScheduleContainerScope(data: data);
}
