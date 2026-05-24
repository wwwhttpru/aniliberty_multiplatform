import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template promotions_container_output_scope}
/// Interface for output scope of Promotions Container.
/// {@endtemplate}
abstract interface class PromotionsContainerOutputScope {
  ///
  /// * Domain *
  ///

  abstract final PromotionsSM promotionsSM;

  ///
  /// * Widget *
  ///

  abstract final IPromotionsWM promotionsWM;
}

/// {@template promotions_container_input_scope}
/// Input scope for Promotions Container.
/// {@endtemplate}
@immutable
class PromotionsContainerInputScope {
  /// Network client for API requests.
  final AppNetwork appNetwork;

  /// {@macro promotions_container_input_scope}
  const PromotionsContainerInputScope({
    required this.appNetwork,
  });
}

class PromotionsContainerScope
    extends DataScopeContainer<PromotionsContainerInputScope>
    implements PromotionsContainerOutputScope {
  @override
  PromotionsSM get promotionsSM => _promotionsSM.get;

  @override
  IPromotionsWM get promotionsWM => _promotionsWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_promotionsSM},
  ];

  PromotionsContainerScope({required super.data});

  late final _remoteDB = dep<IPromotionsRemoteDB>(
    () => PromotionsRemoteDB(appNetwork: data.appNetwork),
  );

  late final _repository = dep<IPromotionsRepository>(
    () => PromotionsRepository(remoteDB: _remoteDB.get),
  );

  late final _promotionsSM = rawAsyncDep<PromotionsSM>(
    () => PromotionsSM(repository: _repository.get),
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _promotionsWM = dep<IPromotionsWM>(
    () => PromotionsWM(promotionsSM: _promotionsSM.get),
  );
}

class PromotionsContainerHolder
    extends
        BaseDataScopeHolder<
          PromotionsContainerOutputScope,
          PromotionsContainerScope,
          PromotionsContainerInputScope
        > {
  PromotionsContainerHolder();

  @override
  PromotionsContainerScope createContainer(
    PromotionsContainerInputScope data,
  ) => PromotionsContainerScope(data: data);
}
