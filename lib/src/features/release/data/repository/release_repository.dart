import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/data/datasource/datasource.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:meta/meta.dart';

@immutable
final class ReleaseRepository implements IReleaseRepository {
  final IReleaseRemoteDB _remoteDB;

  const ReleaseRepository({
    required this._remoteDB,
  });

  @override
  Future<AnimeReleasesModel> releasesLatestFromNetwork({
    required int limit,
  }) => _remoteDB.releasesLatest(limit);

  @override
  Future<AnimeReleasesModel> releasesRandomFromNetwork({
    required int limit,
  }) => _remoteDB.releasesRandom(limit);

  @override
  Future<AnimeReleaseModel> releasesByAliasOrIDFromNetwork(
    String aliasOrId,
  ) => _remoteDB.releasesByAliasOrID(aliasOrId);

  @override
  Future<AnimeReleaseEpisodeModel> releaseEpisodeByIdFromNetwork(
    String releaseEpisodeId,
  ) => _remoteDB.releaseEpisodeById(releaseEpisodeId);
}
