import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/feed/router/feed_navigation_module.dart';
import 'package:aniliberty_multiplatform/src/features/feed/router/feed_route.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template feed_container_input_scope}
/// Dependencies required from outside for Feed Container.
/// {@endtemplate}
@immutable
final class FeedContainerInputScope {
  /// {@macro feed_route}
  final FeedRoute feedRoute;

  /// Navigation container for registering navigation module.
  final ModuleNavigationContainer navigationContainer;

  /// {@macro feed_container_input_scope}
  const FeedContainerInputScope({
    required this.feedRoute,
    required this.navigationContainer,
  });
}

/// {@template feed_container_output_scope}
/// Dependencies provided by Feed Container.
/// {@endtemplate}
abstract interface class FeedContainerOutputScope {}

/// {@template feed_container_scope}
/// Scope for Feed Container.
///
/// Registers [FeedNavigationModule] with the navigation container.
/// {@endtemplate}
class FeedContainerScope extends DataScopeContainer<FeedContainerInputScope>
    implements FeedContainerOutputScope {
  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_navigationModule},
  ];

  FeedContainerScope({required super.data});

  late final _route = dep<FeedRoute>(
    () => data.feedRoute,
  );

  /// {@macro feed_navigation_module}
  late final _navigationModule = rawAsyncDep<FeedNavigationModule>(
    () => FeedNavigationModule(route: _route.get),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );
}

/// {@template feed_container_holder}
/// Holder for Feed Container.
/// {@endtemplate}
class FeedContainerHolder
    extends
        BaseDataScopeHolder<
          FeedContainerOutputScope,
          FeedContainerScope,
          FeedContainerInputScope
        > {
  /// {@macro feed_container_holder}
  FeedContainerHolder();

  @override
  FeedContainerScope createContainer(
    FeedContainerInputScope data,
  ) => FeedContainerScope(data: data);
}
