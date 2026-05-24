import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

abstract interface class IFranchisesRepository {
  /// Возвращает список франшиз.
  Future<AnimeFranchisesModel> readFranchisesFromNetwork();

  /// Возвращает данные франшизы по [franchiseId].
  Future<AnimeFranchiseModel> readFranchiseByIdFromNetwork({
    required String franchiseId,
  });

  /// Возвращает список случайных франшиз.
  ///
  /// [limit] - количество случайных франшиз
  Future<AnimeFranchisesModel> readRandomFranchisesFromNetwork({
    required int limit,
  });

  /// Возвращает список франшиз, в которых участвует релиз.
  ///
  /// [releaseId] - ID релиза
  Future<AnimeFranchisesModel> readFranchisesByReleaseIdFromNetwork({
    required int releaseId,
  });
}
