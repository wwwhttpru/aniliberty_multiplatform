// ignore_for_file: always_put_required_named_parameters_first

import 'package:aniliberty_multiplatform/src/datasource_v2/anime_common/anime_common.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/anime_franchise/anime_franchise_release_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'anime_franchise_model.freezed.dart';
part 'anime_franchise_model.g.dart';

/// Данные по франшизе
@freezed
abstract class AnimeFranchiseModel with _$AnimeFranchiseModel {
  const AnimeFranchiseModel._();

  /// Возвращает лейб годов
  ///
  /// example: 2010 — 2020 or 2020 if first and last equals
  String get yearsLabel {
    if (firstYear == lastYear) {
      return firstYear.toString();
    }

    return '$firstYear — $lastYear';
  }

  /// Возвращает лейб Релизов и эпизодов
  ///
  /// example: 3 сезона • 41 эпизод
  String get totalReleaseAndEpisodesLabel {
    final seasonLabel = Intl.plural(
      totalReleases,
      one: '$totalReleases сезон',
      few: '$totalReleases сезона',
      many: '$totalReleases сезонов',
      other: '$totalReleases сезонов', // Фолбэк
      locale: 'ru', // Указываем локаль
      name: 'SeasonText',
      args: [totalReleases],
    );

    final episodeLabel = Intl.plural(
      totalEpisodes,
      one: '$totalEpisodes эпизод',
      few: '$totalEpisodes эпизода',
      many: '$totalEpisodes эпизодов',
      other: '$totalEpisodes эпизодов', // Фолбэк
      locale: 'ru', // Указываем локаль
      name: 'EpisodeText',
      args: [totalEpisodes],
    );

    return '$seasonLabel • $episodeLabel';
  }

  /// Возвращает всю информацию в одной строке, разделяя через •
  String get allInfoLabel {
    final duration = totalDuration ?? '$totalDurationInSeconds';
    return '$yearsLabel • $totalReleaseAndEpisodesLabel • $duration';
  }

  const factory AnimeFranchiseModel({
    /// Идентификатор франшизы
    ///
    /// example: 116e17d2-e89f-4ffc-bfa4-b45ae4c41e92
    @JsonKey(name: 'id') required String id,

    /// Название франшизы (на русском)
    ///
    /// example: Re: Жизнь в другом мире с нуля
    @JsonKey(name: 'name') required String name,

    /// Название франшизы (на английском)
    ///
    /// example: Re: Zero kara Hajimeru Isekai Seikatsu
    @JsonKey(name: 'name_english') required String nameEnglish,

    /// Рейтинг франшизы
    ///
    /// example: 8.45
    @JsonKey(name: 'rating') double? rating,

    /// Год последнего релиза
    ///
    /// example: 2023
    @JsonKey(name: 'last_year') required int lastYear,

    /// Год первого релиза
    ///
    /// example: 2010
    @JsonKey(name: 'first_year') required int firstYear,

    /// Количество релизов
    ///
    /// example: 10
    @JsonKey(name: 'total_releases') required int totalReleases,

    /// Общее количество эпизодов
    ///
    /// example: 25
    @JsonKey(name: 'total_episodes') required int totalEpisodes,

    /// Общая длительность франшизы
    ///
    /// example: 2 дня 5 часов
    @JsonKey(name: 'total_duration') String? totalDuration,

    /// Общая длительность франшизы в секундах
    ///
    /// example: 183600
    @JsonKey(name: 'total_duration_in_seconds')
    required int totalDurationInSeconds,

    /// Превью франшизы
    @JsonKey(name: 'image') required PosterPreviewModel image,

    /// Данные по релизам в франшизе
    @JsonKey(name: 'franchise_releases')
    List<AnimeFranchiseReleaseModel>? franchiseReleases,
  }) = _AnimeFranchiseModel;

  /// Generate Class from Map<String, Object?>
  factory AnimeFranchiseModel.fromJson(Map<String, Object?> json) =>
      _$AnimeFranchiseModelFromJson(json);
}
