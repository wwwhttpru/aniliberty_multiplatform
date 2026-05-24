import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// Remote data source for franchises.
///
/// Fetches franchise data from the Anilibria API.
/// See API docs: <https://anilibria.top/api/docs/v1#/>
abstract interface class IFranchisesRemoteDB {
  /// Returns the list of franchises.
  Future<AnimeFranchisesModel> readFranchises();

  /// Returns franchise data by [franchiseId].
  Future<AnimeFranchiseModel> readFranchiseById({
    required String franchiseId,
  });

  /// Returns a list of random franchises.
  ///
  /// [limit] is the number of random franchises to return.
  Future<AnimeFranchisesModel> readRandomFranchises({
    required int limit,
  });

  /// Returns the list of franchises that include the given release.
  ///
  /// [releaseId] is the ID of the release.
  Future<AnimeFranchisesModel> readFranchisesByReleaseId({
    required int releaseId,
  });
}

/// Implementation of [IFranchisesRemoteDB] using the Anilibria API.
@immutable
class FranchisesRemoteDB implements IFranchisesRemoteDB {
  final AppNetwork _appNetwork;

  const FranchisesRemoteDB({required this._appNetwork});

  @override
  Future<AnimeFranchisesModel> readFranchises() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/franchises',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeFranchisesModel.fromJson({'franchises': data});
  }

  @override
  Future<AnimeFranchiseModel> readFranchiseById({
    required String franchiseId,
  }) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/franchises/$franchiseId',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeFranchiseModel.fromJson(data);
  }

  @override
  Future<AnimeFranchisesModel> readRandomFranchises({
    required int limit,
  }) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/franchises/random',
      queryParameters: {'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeFranchisesModel.fromJson({'franchises': data});
  }

  @override
  Future<AnimeFranchisesModel> readFranchisesByReleaseId({
    required int releaseId,
  }) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/franchises/release/$releaseId',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');

    return AnimeFranchisesModel.fromJson({'franchises': data});
  }
}
