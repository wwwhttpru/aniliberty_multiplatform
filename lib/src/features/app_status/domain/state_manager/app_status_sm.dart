import 'package:aniliberty_multiplatform/src/features/app_status/domain/repository/app_status_repository.dart';
import 'package:aniliberty_multiplatform/src/features/app_status/domain/state/app_status_state.dart';
import 'package:yx_state/yx_state.dart';

/// {@template app_status_sm}
/// State manager for app status feature
/// {@endtemplate}
final class AppStatusSM extends StateManager<AppStatusState> {
  /// {@macro i_app_status_repository}
  final IAppStatusRepository _repository;

  /// {@macro app_status_sm}
  AppStatusSM({
    required this._repository,
  }) : super(const AppStatusState.idle());

  /// Reads the app status from the repository.
  void read() => handle(
    (emit) async {
      emit(const AppStatusState.progress());
      try {
        final appStatus = await _repository.getStatus();
        emit(AppStatusState.success(appStatus: appStatus));
      } on Object catch (error, sk) {
        emit(const AppStatusState.error());
        addError(error, sk);
      }
    },
    identifier: 'read',
  );
}
