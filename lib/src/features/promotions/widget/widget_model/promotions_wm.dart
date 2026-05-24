import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:meta/meta.dart';

/// {@template i_promotions_wm}
/// Interface for promotions widget model.
/// {@endtemplate}
abstract interface class IPromotionsWM {
  /// Load the data for the promotion banner
  void read();
}

/// {@macro i_promotions_wm}
@immutable
class PromotionsWM implements IPromotionsWM {
  /// {@macro promotions_sm}
  final PromotionsSM _promotionsSM;

  /// {@macro promotions_wm}
  ///
  /// Creates a new instance of [PromotionsWM].
  ///
  /// [_promotionsSM] - The state manager for promotions
  const PromotionsWM({
    required this._promotionsSM,
  });

  @override
  void read() {
    final state = _promotionsSM.state;
    if (state.isProgress || state.isSuccess) {
      return;
    }

    _promotionsSM.read();
  }
}
