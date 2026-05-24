import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:yx_state/yx_state.dart';

/// {@template promotions_sm}
/// State manager for managing media promotions state.
///
/// Manages the state of media promotions and handles the loading of promotional materials.
/// {@endtemplate}
class PromotionsSM extends StateManager<PromotionsState> {
  /// {@macro i_promotions_repository}
  final IPromotionsRepository _repository;

  /// {@macro promotions_sm}
  ///
  /// Creates a new instance of [PromotionsSM].
  ///
  /// [_repository] - The repository for promotions operations
  PromotionsSM({
    required this._repository,
  }) : super(const PromotionsState.idle());

  /// Loads the list of promotional materials from the network.
  ///
  /// Emits [PromotionsState.progress] while loading, [PromotionsState.success]
  /// on success, or [PromotionsState.error] on failure.
  void read() => handle(
    (emit) async {
      emit(const PromotionsState.progress());
      try {
        final mediaPromotions = await _repository.readPromotionsFromNetwork();
        emit(PromotionsState.success(mediaPromotions: mediaPromotions));
      } on Object catch (error, sk) {
        emit(const PromotionsState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );
}
