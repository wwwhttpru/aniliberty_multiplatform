import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/router/catalog_navigation_module.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/router/catalog_route.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget.dart';
import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template catalog_container_input_scope}
/// Interface for input scope of Catalog Container
/// {@endtemplate}
@immutable
final class CatalogContainerInputScope {
  /// App network to use for network operations
  final AppNetwork appNetwork;

  /// {@macro catalog_route}
  final CatalogRoute catalogRoute;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// Releases navigation interactor
  final IReleasesNavigationInteractor releasesNavigationInteractor;

  /// {@macro catalog_container_input_scope}
  const CatalogContainerInputScope({
    required this.appNetwork,
    required this.catalogRoute,
    required this.navigationContainer,
    required this.routeResolver,
    required this.releasesNavigationInteractor,
  });
}

/// {@template catalog_container_output_scope}
/// Interface for output scope of Catalog Container
/// {@endtemplate}
abstract interface class CatalogContainerOutputScope {
  /// Catalog release state manager
  abstract final CatalogReleaseSM catalogReleaseSM;

  /// Catalog references state manager
  abstract final CatalogReferencesSM catalogReferencesSM;

  /// Catalog filter state manager
  abstract final CatalogFilterSM catalogFilterSM;

  /// Catalog release widget model
  abstract final ICatalogReleaseWM catalogReleaseWM;

  /// Catalog filter widget model
  abstract final ICatalogFilterWM catalogFilterWM;
}

/// {@template catalog_container_scope}
/// Scope for Catalog Container
/// {@endtemplate}
class CatalogContainerScope
    extends DataScopeContainer<CatalogContainerInputScope>
    implements CatalogContainerOutputScope {
  @override
  CatalogReleaseSM get catalogReleaseSM => _catalogReleaseSM.get;

  @override
  CatalogReferencesSM get catalogReferencesSM => _catalogReferencesSM.get;

  @override
  CatalogFilterSM get catalogFilterSM => _catalogFilterSM.get;

  @override
  ICatalogReleaseWM get catalogReleaseWM => _catalogReleaseWM.get;

  @override
  ICatalogFilterWM get catalogFilterWM => _catalogFilterWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_catalogFilterSM, _catalogReferencesSM, _catalogReleaseSM},
    {_controller, _navigationModule},
    {_catalogReleaseWM},
  ];

  CatalogContainerScope({required super.data});

  /// {@macro i_catalog_remote_db}
  late final _remoteDB = dep<ICatalogRemoteDB>(
    () => CatalogRemoteDB(appNetwork: data.appNetwork),
  );

  /// {@macro i_catalog_repository}
  late final _repository = dep<ICatalogRepository>(
    () => CatalogRepository(remoteDB: _remoteDB.get),
  );

  /// {@macro catalog_release_sm}
  late final _catalogReleaseSM = rawAsyncDep<CatalogReleaseSM>(
    () => CatalogReleaseSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro catalog_references_sm}
  late final _catalogReferencesSM = rawAsyncDep<CatalogReferencesSM>(
    () => CatalogReferencesSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro catalog_filter_sm}
  late final _catalogFilterSM = rawAsyncDep<CatalogFilterSM>(
    CatalogFilterSM.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro catalog_route}
  late final _route = dep<CatalogRoute>(
    () => data.catalogRoute,
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro i_catalog_navigation_interactor}
  late final _navigationInteractor = dep<ICatalogNavigationInteractor>(
    () => CatalogNavigationInteractor(
      navigationController: _controller.get,
      route: _route.get,
    ),
  );

  /// {@macro catalog_navigation_module}
  late final _navigationModule = rawAsyncDep<CatalogNavigationModule>(
    () => CatalogNavigationModule(route: _route.get),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// {@macro i_catalog_release_wm}
  late final _catalogReleaseWM = rawAsyncDep<CatalogReleaseWM>(
    () => CatalogReleaseWM(
      catalogReleaseSM: _catalogReleaseSM.get,
      catalogFilterSM: _catalogFilterSM.get,
      catalogNavigationInteractor: _navigationInteractor.get,
      releasesNavigationInteractor: data.releasesNavigationInteractor,
    ),
    init: (value) => value.initialize(),
    dispose: (value) => value.close(),
  );

  /// {@macro i_catalog_filter_wm}
  late final _catalogFilterWM = dep<ICatalogFilterWM>(
    () => CatalogFilterWM(
      catalogReferencesSM: _catalogReferencesSM.get,
      catalogFilterSM: _catalogFilterSM.get,
      catalogNavigationInteractor: _navigationInteractor.get,
    ),
  );
}

/// {@template catalog_container_holder}
/// Holder for Catalog Container
/// {@endtemplate}
class CatalogContainerHolder
    extends
        BaseDataScopeHolder<
          CatalogContainerOutputScope,
          CatalogContainerScope,
          CatalogContainerInputScope
        > {
  /// {@macro catalog_container_holder}
  CatalogContainerHolder();

  @override
  CatalogContainerScope createContainer(
    CatalogContainerInputScope data,
  ) => CatalogContainerScope(data: data);
}
