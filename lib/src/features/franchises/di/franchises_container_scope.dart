import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template franchises_container_input_scope}
/// Dependencies required from outside for Franchises Container.
/// {@endtemplate}
@immutable
final class FranchisesContainerInputScope {
  /// App network for network operations.
  final AppNetwork appNetwork;

  /// Navigation container for creating navigation controller.
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for feed tab navigation.
  final RouteNodeResolver routeResolver;

  /// {@macro franchises_container_input_scope}
  const FranchisesContainerInputScope({
    required this.appNetwork,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template franchises_container_output_scope}
/// Dependencies provided by Franchises Container.
/// {@endtemplate}
abstract interface class FranchisesContainerOutputScope {
  /// State manager for franchise container lifecycle.
  abstract final FranchiseContainerSM franchiseContainerSM;

  /// Remote data source for franchises.
  abstract final IFranchisesRemoteDB remoteDB;

  /// Franchises repository.
  abstract final IFranchisesRepository repository;

  /// Franchises navigation interactor.
  abstract final IFranchisesNavigationInteractor navigationInteractor;

  /// State manager for all franchises list.
  abstract final FranchisesSM franchisesAllSM;

  /// State manager for random franchises.
  abstract final FranchisesSM franchisesRandomSM;

  /// Widget model for all franchises list.
  abstract final IFranchisesAllWM franchisesAllWM;

  /// Widget model for random franchises.
  abstract final IFranchisesRandomWM franchisesRandomWM;
}

/// {@template franchises_container_scope}
/// Scope for Franchises Container.
/// {@endtemplate}
class FranchisesContainerScope
    extends DataScopeContainer<FranchisesContainerInputScope>
    implements FranchisesContainerOutputScope {
  @override
  FranchiseContainerSM get franchiseContainerSM => _franchiseContainerSM.get;

  @override
  IFranchisesRemoteDB get remoteDB => _remoteDB.get;

  @override
  IFranchisesRepository get repository => _repository.get;

  @override
  IFranchisesNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  FranchisesSM get franchisesAllSM => _franchisesAllSM.get;

  @override
  FranchisesSM get franchisesRandomSM => _franchisesRandomSM.get;

  @override
  IFranchisesAllWM get franchisesAllWM => _franchisesAllWM.get;

  @override
  IFranchisesRandomWM get franchisesRandomWM => _franchisesRandomWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_navigationModule, _navigationController},
    {_franchiseContainerSM},
    {_franchisesAllSM, _franchisesRandomSM},
  ];

  FranchisesContainerScope({required super.data});

  late final _franchisesRoute = dep<FranchisesRoute>(
    () => const FranchisesRoute(),
  );

  late final _navigationModule = rawAsyncDep<FranchisesNavigationModule>(
    () => FranchisesNavigationModule(route: _franchisesRoute.get),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  late final _franchiseContainerSM = asyncDep(
    () => FranchiseContainerSM(
      route: _franchisesRoute.get,
      parent: this,
      nodeReadable: _navigationController.get,
    ),
  );

  late final _remoteDB = dep(
    () => FranchisesRemoteDB(appNetwork: data.appNetwork),
  );

  late final _repository = dep(
    () => FranchisesRepository(remoteDB: _remoteDB.get),
  );

  late final _navigationInteractor = dep(
    () => FranchisesNavigationInteractor(
      navigationController: _navigationController.get,
      route: _franchisesRoute.get,
    ),
  );

  late final _navigationController = rawAsyncDep(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _franchisesAllSM = rawAsyncDep(
    () => FranchisesSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _franchisesRandomSM = rawAsyncDep(
    () => FranchisesSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _franchisesAllWM = dep(
    () => FranchisesAllWM(franchisesSM: _franchisesAllSM.get),
  );

  late final _franchisesRandomWM = dep(
    () => FranchisesRandomWM(
      franchisesSM: _franchisesRandomSM.get,
      navigationInteractor: _navigationInteractor.get,
    ),
  );
}

/// {@template franchises_container_holder}
/// Holder for Franchises Container.
/// {@endtemplate}
class FranchisesContainerHolder
    extends
        BaseDataScopeHolder<
          FranchisesContainerOutputScope,
          FranchisesContainerScope,
          FranchisesContainerInputScope
        > {
  /// {@macro franchises_container_holder}
  FranchisesContainerHolder();

  @override
  FranchisesContainerScope createContainer(
    FranchisesContainerInputScope data,
  ) => FranchisesContainerScope(data: data);
}
