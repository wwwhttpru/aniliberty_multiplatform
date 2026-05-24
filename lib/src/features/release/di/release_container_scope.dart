import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template release_container_input_scope}
/// Dependencies required from outside for Release Container.
/// {@endtemplate}
@immutable
final class ReleaseContainerInputScope {
  /// Release repository for loading release by alias or id.
  final IReleaseRepository releaseRepository;

  /// Releases navigation interactor for opening episodes.
  final IReleasesNavigationInteractor navigationInteractor;

  /// Release alias or identifier.
  final String aliasOrId;

  /// {@macro release_container_input_scope}
  const ReleaseContainerInputScope({
    required this.releaseRepository,
    required this.navigationInteractor,
    required this.aliasOrId,
  });
}

/// {@template release_container_output_scope}
/// Dependencies provided by Release Container.
/// {@endtemplate}
abstract interface class ReleaseContainerOutputScope {
  /// State manager for release.
  abstract final ReleaseSM releaseSM;

  /// Widget model for release.
  abstract final IReleaseWM releaseWM;
}

/// {@template release_container_scope}
/// Scope for a single release container.
/// {@endtemplate}
class ReleaseContainerScope
    extends DataScopeContainer<ReleaseContainerInputScope>
    implements ReleaseContainerOutputScope {
  @override
  ReleaseSM get releaseSM => _releaseSM.get;

  @override
  IReleaseWM get releaseWM => _releaseWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_releaseSM},
  ];

  ReleaseContainerScope({required super.data});

  late final _releaseSM = rawAsyncDep(
    () => ReleaseSM(
      aliasOrId: data.aliasOrId,
      repository: data.releaseRepository,
    ),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _releaseWM = dep(
    () => ReleaseWM(
      releaseSM: _releaseSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
  );
}

/// {@template release_container_holder}
/// Holder for Release Container.
/// {@endtemplate}
class ReleaseContainerHolder
    extends BaseDataScopeHolder<
        ReleaseContainerOutputScope,
        ReleaseContainerScope,
        ReleaseContainerInputScope> {
  /// {@macro release_container_holder}
  ReleaseContainerHolder();

  @override
  ReleaseContainerScope createContainer(ReleaseContainerInputScope data) =>
      ReleaseContainerScope(data: data);
}
