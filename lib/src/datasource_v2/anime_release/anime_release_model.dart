// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_genre/anime_genre.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_age_rating_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_episode_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_member_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_name_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_publish_day_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_season_model.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_release/anime_release_type_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'anime_release_model.freezed.dart';
part 'anime_release_model.g.dart';

@freezed
abstract class AnimeReleaseModel with _$AnimeReleaseModel {
  /// Возвращает строку в формате "Год • Сезон • Тип • Возрастное ограничение"
  String get yearSeasonTypeAgeLabel {
    final year = this.year;
    final season = this.season.description;
    final type = this.type.description;
    final age = ageRating.label;

    return '$year • $season • $type • $age';
  }

  /// Возвращает строку в формате "Жанр-1 • Жанр-2"
  String get genresLabel =>
      genres?.map((genre) => genre.name).join(' • ') ?? '';

  /// Возвращает строку в формате "~ 123 мин."
  String get averageDurationLabel {
    final min = averageDurationOfEpisode;
    if (min == null) {
      return '—';
    }

    final hours = min ~/ 60;
    final minutes = min % 60;

    if (hours > 0) {
      return '~ $hours ч. $minutes мин.';
    }

    return '~ $minutes мин.';
  }

  /// Возвращает строку в формате "123 часа, 45 минут"
  String get totalWatchTimeLabel {
    final average = averageDurationOfEpisode;
    final total = episodesTotal;

    if (average == null || total == null) {
      return '—';
    }

    final totalMinutes = average * total;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0) {
      return '$hours ч. $minutes мин.';
    }

    return '$minutes мин.';
  }

  /// Возвращает строку в формате "123 эпизода"
  String get episodesTotalLabel {
    final total = episodesTotal;

    if (total == null) {
      return '—';
    }

    return Intl.plural(
      total,
      one: '$total эпизод',
      few: '$total эпизода',
      many: '$total эпизодов',
      other: '$total эпизодов', // Фолбэк
      locale: 'ru', // Указываем локаль
      name: 'EpisodeText',
      args: [total],
    );
  }

  const factory AnimeReleaseModel({
    /// Идентификатор
    @JsonKey(name: 'id') required int id,

    /// Тип
    @JsonKey(name: 'type') required AnimeReleaseTypeModel type,

    /// Год
    @JsonKey(name: 'year') required int year,

    /// Название релиза
    @JsonKey(name: 'name') required AnimeReleaseNameModel name,

    /// Ссылка на релиз
    @JsonKey(name: 'alias') required String alias,

    /// Сезон
    @JsonKey(name: 'season') required AnimeReleaseSeasonModel season,

    /// Постер
    @JsonKey(name: 'poster') required PosterPreviewModel poster,

    /// Дата поднятия релиза
    @JsonKey(name: 'fresh_at') DateTime? freshAt,

    /// Дата создания релиза
    @JsonKey(name: 'created_at') DateTime? createdAt,

    /// Дата обновления релиза
    @JsonKey(name: 'updated_at') required DateTime updatedAt,

    /// Релиз в данный момент выходит в стране производства
    @JsonKey(name: 'is_ongoing') required bool isOngoing,

    /// Возрастное ограничение
    @JsonKey(name: 'age_rating') required AnimeReleaseAgeRatingModel ageRating,

    /// День выхода релиза
    @JsonKey(name: 'publish_day')
    required AnimeReleasePublishDayModel publishDay,

    /// Описание релиза
    ///
    /// example: Underworld - мир, ранее недоступный человеческому пониманию...
    @JsonKey(name: 'description') String? description,

    /// Важная информация / Оповещение
    ///
    /// example: Серии выходят по воскресеньям
    @JsonKey(name: 'notification') String? notification,

    /// Всего эпизодов
    ///
    /// example: 36
    @JsonKey(name: 'episodes_total') int? episodesTotal,

    /// Ссылка на внешний плеер
    ///
    /// example: //kodik.info/serial/19176/e15afea155a42c615158e3a743330f3c/720p?translations=false
    @JsonKey(name: 'external_player') String? externalPlayer,

    /// Релиз в в работе / озвучивается
    ///
    /// example: false
    @JsonKey(name: 'is_in_production') required bool isInProduction,

    /// Блокировка по геолокации
    ///
    /// example: false
    @JsonKey(name: 'is_blocked_by_geo') required bool isBlockedByGeo,

    /// Релиз заблокирован правообладателем
    ///
    /// example: false
    @JsonKey(name: 'is_blocked_by_copyrights')
    required bool isBlockedByCopyrights,

    /// Рейтинг по добавлению в коллекцию
    ///
    /// example: 25557
    @JsonKey(name: 'added_in_users_favorites')
    required int addedInUsersFavorites,

    /// Жанры
    @JsonKey(name: 'genres') List<AnimeGenreModel>? genres,

    /// Участник релиза
    @JsonKey(name: 'members') List<AnimeReleaseMemberModel>? members,

    /// Эпизоды
    @JsonKey(name: 'episodes') List<AnimeReleaseEpisodeModel>? episodes,

    /// Средняя продолжительность серий
    @JsonKey(name: 'average_duration_of_episode') int? averageDurationOfEpisode,

    /// Последний эпизод
    @JsonKey(name: 'latest_episode') AnimeReleaseEpisodeModel? latestEpisode,
  }) = _AnimeReleaseModel;

  const AnimeReleaseModel._();

  /// Generate Class from Map<String, Object?>
  factory AnimeReleaseModel.fromJson(Map<String, Object?> json) =>
      _$AnimeReleaseModelFromJson(json);
}
