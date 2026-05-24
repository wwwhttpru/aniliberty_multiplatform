import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

abstract interface class IReleaseRemoteDB {
  /// Возвращает данные по последним релизам
  ///
  /// [limit] - Количество последних релизов в выдаче
  Future<AnimeReleasesModel> releasesLatest(int limit);

  /// Возвращает данные по случайным релизам
  ///
  /// [limit] - Количество случайных релизов
  Future<AnimeReleasesModel> releasesRandom(int limit);

  /// Возвращает данные по релизу
  ///
  /// [aliasOrId] - Alias или Id релиза
  Future<AnimeReleaseModel> releasesByAliasOrID(String aliasOrId);

  /// Возвращает данные по эпизоду релиза
  ///
  /// [releaseEpisodeId] - Идентификатор эпизода
  Future<AnimeReleaseEpisodeModel> releaseEpisodeById(
    String releaseEpisodeId,
  );
}

/// Подробнее об API: <https://anilibria.top/api/docs/v1#/>
@immutable
final class ReleaseRemoteDB implements IReleaseRemoteDB {
  final AppNetwork _appNetwork;

  const ReleaseRemoteDB({required this._appNetwork});

  @override
  Future<AnimeReleasesModel> releasesLatest(int limit) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/releases/latest',
      queryParameters: {'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeReleasesModel.fromJson({'releases': data});
  }

  @override
  Future<AnimeReleasesModel> releasesRandom(int limit) async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/anime/releases/random',
      queryParameters: {'limit': limit},
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeReleasesModel.fromJson({'releases': data});
  }

  @override
  Future<AnimeReleaseModel> releasesByAliasOrID(String aliasOrId) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/releases/$aliasOrId',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeReleaseModel.fromJson(data);
  }

  @override
  Future<AnimeReleaseEpisodeModel> releaseEpisodeById(
    String releaseEpisodeId,
  ) async {
    final response = await _appNetwork.coreV2.get<Map<String, Object?>>(
      '/anime/releases/episodes/$releaseEpisodeId',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return AnimeReleaseEpisodeModel.fromJson(data);
  }
}
