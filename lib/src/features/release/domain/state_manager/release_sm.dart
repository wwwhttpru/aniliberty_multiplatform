import 'package:aniliberty_multiplatform/src/features/release/domain/repository/repository.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/state/state.dart';
import 'package:yx_state/yx_state.dart';

class ReleaseSM extends StateManager<ReleaseState> {
  final String _aliasOrId;
  final IReleaseRepository _repository;

  ReleaseSM({required this._aliasOrId, required this._repository})
    : super(const ReleaseState.idle());

  void read() {
    handle((emit) async {
      emit(const ReleaseState.progress());
      try {
        final release = await _repository.releasesByAliasOrIDFromNetwork(
          _aliasOrId,
        );

        emit(ReleaseState.success(release: release));
      } on Object catch (error, sk) {
        emit(const ReleaseState.error());
        addError(error, sk);
      }
    });
  }
}
