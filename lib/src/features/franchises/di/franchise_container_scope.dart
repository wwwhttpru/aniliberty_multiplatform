import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template franchise_container_input_scope}
/// Dependencies required from outside for Franchise Container.
/// {@endtemplate}
@immutable
final class FranchiseContainerInputScope {
  /// Franchises repository for loading franchise by id.
  final IFranchisesRepository repository;

  /// Franchise identifier.
  final String franchiseId;

  /// {@macro franchise_container_input_scope}
  const FranchiseContainerInputScope({
    required this.repository,
    required this.franchiseId,
  });
}

/// {@template franchise_container_output_scope}
/// Dependencies provided by Franchise Container.
/// {@endtemplate}
abstract interface class FranchiseContainerOutputScope {
  /// State manager for franchise.
  abstract final FranchiseSM franchiseSM;

  /// Widget model for franchise.
  abstract final IFranchiseWM franchiseWM;
}

/// {@template franchise_container_scope}
/// Scope for a single franchise container.
/// {@endtemplate}
class FranchiseContainerScope
    extends DataScopeContainer<FranchiseContainerInputScope>
    implements FranchiseContainerOutputScope {
  @override
  FranchiseSM get franchiseSM => _franchiseSM.get;

  @override
  IFranchiseWM get franchiseWM => _franchiseWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_franchiseSM},
  ];

  FranchiseContainerScope({required super.data});

  late final _franchiseSM = rawAsyncDep(
    () => FranchiseSM(
      franchiseId: data.franchiseId,
      repository: data.repository,
    ),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _franchiseWM = dep(
    () => FranchiseWM(franchiseSM: _franchiseSM.get),
  );
}

/// {@template franchise_container_holder}
/// Holder for Franchise Container.
/// {@endtemplate}
class FranchiseContainerHolder
    extends BaseDataScopeHolder<
        FranchiseContainerOutputScope,
        FranchiseContainerScope,
        FranchiseContainerInputScope> {
  /// {@macro franchise_container_holder}
  FranchiseContainerHolder();

  @override
  FranchiseContainerScope createContainer(
    FranchiseContainerInputScope data,
  ) => FranchiseContainerScope(data: data);
}
