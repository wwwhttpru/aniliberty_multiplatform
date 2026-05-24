import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// Репозиторий для получения информации о релизах (тайтлах)
abstract interface class IReleaseRepository {
  /// Возвращает данные по последним релизам
  ///
  /// [limit] - Количество последних релизов в выдаче
  Future<AnimeReleasesModel> releasesLatestFromNetwork({required int limit});

  /// Возвращает данные по случайным релизам
  ///
  /// [limit] - Количество случайных релизов
  Future<AnimeReleasesModel> releasesRandomFromNetwork({required int limit});

  /// Возвращает данные по релизу
  ///
  /// [aliasOrId] - Alias или Id релиза
  Future<AnimeReleaseModel> releasesByAliasOrIDFromNetwork(String aliasOrId);

  /// Возвращает данные по эпизоду релиза
  ///
  /// [releaseEpisodeId] - Идентификатор эпизода
  Future<AnimeReleaseEpisodeModel> releaseEpisodeByIdFromNetwork(
    String releaseEpisodeId,
  );
}
