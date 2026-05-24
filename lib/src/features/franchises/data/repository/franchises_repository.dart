import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/data/datasource/franchises_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/franchises/domain/domain.dart';
import 'package:meta/meta.dart';

/// Repository for franchise data.
///
/// Delegates to [IFranchisesRemoteDB] for network access.
@immutable
class FranchisesRepository implements IFranchisesRepository {
  final IFranchisesRemoteDB _remoteDB;

  const FranchisesRepository({
    required this._remoteDB,
  });

  @override
  Future<AnimeFranchisesModel> readFranchisesFromNetwork() =>
      _remoteDB.readFranchises();

  @override
  Future<AnimeFranchiseModel> readFranchiseByIdFromNetwork({
    required String franchiseId,
  }) => _remoteDB.readFranchiseById(franchiseId: franchiseId);

  @override
  Future<AnimeFranchisesModel> readRandomFranchisesFromNetwork({
    required int limit,
  }) => _remoteDB.readRandomFranchises(limit: limit);

  @override
  Future<AnimeFranchisesModel> readFranchisesByReleaseIdFromNetwork({
    required int releaseId,
  }) => _remoteDB.readFranchisesByReleaseId(releaseId: releaseId);
}
