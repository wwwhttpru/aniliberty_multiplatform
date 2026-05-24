import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotions_state.freezed.dart';

/// {@template promotions_state}
/// State for promotions feature.
///
/// Represents different states of the promotions loading process:
/// - idle - Waiting for user action
/// - progress - Loading data
/// - success - Data loaded successfully
/// - error - Failed to load data
/// {@endtemplate}
///
/// {@macro promotions_state}
///
/// Initial state, waiting for user action.
@freezed
sealed class PromotionsState with _$PromotionsState {
  const PromotionsState._();

  /// Returns true if the state is idle (waiting for user action)
  bool get isIdle => maybeMap(orElse: () => false, idle: (_) => true);

  /// Returns true if the state is progress (loading data)
  bool get isProgress => maybeMap(orElse: () => false, progress: (_) => true);

  /// Returns true if the state is success (data loaded successfully)
  bool get isSuccess => maybeMap(orElse: () => false, success: (_) => true);

  /// Returns true if the state is error (failed to load data)
  bool get isError => maybeMap(orElse: () => false, error: (_) => true);

  /// Initial state, waiting for user action.
  const factory PromotionsState.idle() = _IdlePromotionsState;

  /// Data is being loaded from the network.
  const factory PromotionsState.progress() = _ProgressPromotionsState;

  /// Data has been successfully loaded.
  const factory PromotionsState.success({
    required MediaPromotionsModel mediaPromotions,
  }) = _SuccessPromotionsState;

  /// Failed to load data.
  const factory PromotionsState.error() = _ErrorPromotionsState;
}
