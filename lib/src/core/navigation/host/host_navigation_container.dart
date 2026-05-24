part of '../base/navigation_container.dart';

/// {@template host_navigation_container}
/// Host navigation container implementation of [ModuleNavigationContainer].
///
/// Manages the lifecycle of navigation modules, coordinates route declarations
/// and guards from multiple modules, and provides the router configuration
/// for Flutter's navigation system.
///
/// This class is responsible for:
/// - Initializing and disposing the navigation container
/// - Registering and unregistering navigation modules
/// - Combining route declarations and guards from all modules
/// - Creating and managing the router configuration
///
/// The container must be initialized before use, and should be disposed
/// when no longer needed to clean up resources.
/// {@endtemplate}
final class HostNavigationContainer implements ModuleNavigationContainer {
  /// The host navigation module.
  final HostNavigationModule _hostModule;

  /// Map of registered navigation modules by name.
  final Iterable<NavigationModule> _sourceModules;

  /// Map of attached navigation modules by name.
  final Map<String, NavigationModule> _attachedModules;

  /// Root state manager for navigation state.
  final RouteNodeStateManager _stateManager;

  /// Guard synchronization service.
  final GuardSync _guardSync;

  /// Route node guard manager.
  ///
  /// Manages guards from all registered modules, combining them into a
  /// unified guard configuration.
  final HostRouteNodeGuard _routeNodeGuard;

  /// Route declaration resolver.
  ///
  /// Manages route declarations from all registered modules, combining
  /// them into a unified declaration map.
  final HostRouteDeclarationResolver _declarationResolver;

  /// Widget route node builder.
  ///
  /// Allows customizing the widget builder for route nodes.
  final RouteNodeWidgetBuilder _widgetRouteNodeBuilder;

  /// Optional notifier that controls the in-app navigation debug panel.
  final DebugPanelModeNotifier? _debugPanelModeNotifier;

  /// Router configuration.
  ///
  /// Created during initialization and contains all components necessary
  /// for Flutter's navigation system.
  YxRouterConfig? _routerConfig;

  @override
  GuardSync get guardSync => _guardSync;

  @override
  NavigationController get navigationController => _stateManager;

  /// Indicates whether the container is initialized.
  ///
  /// The container must be initialized before it can be used. Initialization
  /// is performed by calling [initialize].
  bool get isInitialized => _routerConfig != null;

  /// The router configuration.
  ///
  /// Contains all necessary components for Flutter's navigation system:
  /// router delegate, route information parser, and back button dispatcher.
  ///
  /// Throws [StateError] if the container is not initialized.
  RouterConfig<RouteNode> get routerConfig {
    final config = _routerConfig;

    if (config == null) {
      throw StateError('Router config is not initialized');
    }

    return config;
  }

  /// Creates a new [HostNavigationContainer] instance.
  ///
  /// [_hostModule] - The host navigation module
  /// [_stateManager] - The state manager for navigation state
  /// [_guardSync] - The guard synchronization service
  /// [modules] - Optional pre-registered modules
  /// [routeNodeGuard] - Optional custom guard configuration. Defaults to [HostRouteNodeGuardConfiguration]
  /// [routeDeclarationResolver] - Optional custom declaration resolver. Defaults to [HostRouteDeclarationResolver]
  HostNavigationContainer({
    required this._hostModule,
    required this._stateManager,
    required this._guardSync,
    Iterable<NavigationModule>? modules,
    HostRouteNodeGuard? routeNodeGuard,
    HostRouteDeclarationResolver? routeDeclarationResolver,
    RouteNodeWidgetBuilder? widgetRouteNodeBuilder,
    this._debugPanelModeNotifier,
  }) : _sourceModules = modules ?? const <NavigationModule>[],
       _routeNodeGuard = routeNodeGuard ?? HostRouteNodeGuardConfiguration(),
       _declarationResolver =
           routeDeclarationResolver ??
           HostRouteDeclarationResolver(declarations: const {}),
       _attachedModules = <String, NavigationModule>{},
       _widgetRouteNodeBuilder =
           widgetRouteNodeBuilder ?? const RouteNodeWidgetBuilder();

  @nonVirtual
  @override
  void register(NavigationModule navigationModule) {
    if (!isInitialized) {
      throw StateError('Navigation container not initialized');
    }

    return _attachModule(navigationModule);
  }

  @nonVirtual
  @override
  void unregister(NavigationModule navigationModule) {
    if (!isInitialized) {
      throw StateError('Navigation container not initialized');
    }

    return _detachModule(navigationModule);
  }

  @useResult
  @nonVirtual
  @override
  NavigationController createNavigationController({
    required RouteNodeResolver nodeResolver,
  }) {
    if (!isInitialized) {
      throw StateError('Navigation container not initialized');
    }

    return NavigationController.node(
      stateManager: _stateManager,
      nodeResolver: nodeResolver,
    );
  }

  /// Initializes the navigation container.
  ///
  /// This method must be called before the container can be used. It:
  /// - Attaches the host module and all pre-registered modules
  /// - Triggers guard synchronization
  /// - Creates and attaches the router configuration
  ///
  /// Throws [StateError] if the container is already initialized.
  void initialize() {
    if (isInitialized) {
      throw StateError('Navigation container already initialized');
    }

    final name = _hostModule.name;
    _attachModule(_hostModule);
    _sourceModules.forEach(_attachModule);

    _guardSync.add(GuardSyncReason(message: 'Initialize module: $name'));
    _attachRouterConfig();
  }

  /// Disposes the navigation container.
  ///
  /// This method should be called when the container is no longer needed.
  /// It:
  /// - Detaches all registered modules (including the host module)
  /// - Triggers guard synchronization
  /// - Disposes the router configuration and cleans up resources
  ///
  /// Throws [StateError] if the container is not initialized.
  void dispose() {
    if (!isInitialized) {
      throw StateError('Navigation container not initialized');
    }

    final name = _hostModule.name;
    _attachedModules.values.forEach(_detachModule);
    _detachModule(_hostModule);
    _guardSync.add(GuardSyncReason(message: 'Dispose module: $name'));
    _detachRouterConfig();
  }

  /// Attaches a navigation module to the container.
  ///
  /// Registers the module's guards and declarations with the guard manager
  /// and declaration resolver, making the module's routes available.
  ///
  /// [module] - The navigation module to attach
  ///
  /// Throws [StateError] if a module with the same name is already attached.
  void _attachModule(NavigationModule module) {
    final name = module.name;
    if (_attachedModules.containsKey(name)) {
      throw StateError('Module "$name" is already attached');
    }
    // Вложенные декларации и гварды обсудить: ITAXIMETER-18367, ITAXIMETER-23302
    final guardsFromDeclarations = module.declarations.expand(
      (declaration) => declaration.buildGuards(),
    );
    final guards = [...module.guards, ...guardsFromDeclarations];
    _routeNodeGuard.attach(name, guards);
    _declarationResolver.attach(name, module.declarations);
    _attachedModules[name] = module;
  }

  /// Detaches a navigation module from the container.
  ///
  /// Removes the module's guards and declarations from the guard manager
  /// and declaration resolver, making the module's routes unavailable.
  ///
  /// [module] - The navigation module to detach
  ///
  /// Throws [StateError] if the module is not attached.
  void _detachModule(NavigationModule module) {
    final name = module.name;
    if (!_attachedModules.containsKey(name)) {
      throw StateError('Module "$name" is not attached');
    }
    _routeNodeGuard.detach(name);
    _declarationResolver.detach(name);
    _attachedModules.remove(name);
  }

  /// Creates and attaches the router configuration.
  ///
  /// Builds all components necessary for Flutter's navigation system:
  /// - Back button dispatcher
  /// - Route information parser and provider
  /// - Router delegate with route node builder
  ///
  /// Throws [AssertionError] if router config is already attached.
  void _attachRouterConfig() {
    assert(_routerConfig == null, 'Router config already attached');

    final backButtonDispatcher = RootBackButtonDispatcher();
    const serialization = PrettyUriStateSerialization();
    final informationParser = YxRouteInformationParser(
      stateManager: _stateManager,
      serialization: serialization,
      fallbackBuilder: const RouteInformationParserFallbackBuilderImpl(),
    );
    final informationProvider = YxRouteInformationProvider(
      serialization: serialization,
    );
    final routeNodeBuilder = BaseRouteNodeBuilder(
      routeDeclarationResolver: _declarationResolver,
      widgetRouteNodeBuilder: _widgetRouteNodeBuilder,
    );
    final routerDelegate = YxRouterDelegate(
      stateManager: _stateManager,
      routeNodeBuilder: routeNodeBuilder,
      navigatorKey: _hostModule.routerDelegateNavigatorKey,
      transitionDelegate: _hostModule.routerDelegateTransitionDelegate,
      observers: _hostModule.routerDelegateObservers,
      restorationScopeId: _hostModule.routerDelegateRestorationScopeId,
      backButtonHandler: _hostModule.routerDelegateBackButtonHandler,
      defaultDisplayType: _hostModule.routerDelegateDefaultDisplayType,
      observerReadable: _hostModule.routerDelegateObserverReadable,
      debugPanelModeNotifier: _debugPanelModeNotifier,
      routeDeclarationResolver: _declarationResolver,
      builder: _hostModule.routerDelegateBuilder,
    );
    final config = YxRouterConfig(
      backButtonDispatcher: backButtonDispatcher,
      routerDelegate: routerDelegate,
      routeInformationParser: informationParser,
      routeInformationProvider: informationProvider,
    );
    _routerConfig = config;
  }

  /// Detaches and disposes the router configuration.
  ///
  /// Cleans up all router resources and resets the router config to null.
  ///
  /// Throws [AssertionError] if router config is not attached.
  void _detachRouterConfig() {
    assert(_routerConfig != null, 'Router config not attached');
    _routerConfig?.dispose();
    _routerConfig = null;
  }
}
