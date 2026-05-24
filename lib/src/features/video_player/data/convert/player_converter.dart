import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';

/// Converter class for transforming data models from the API layer
/// to domain models used in the video player feature.
///
/// This class handles the conversion between [AnimeReleaseModel] and [TitleRelease],
/// as well as between [AnimeReleaseEpisodeModel] and [Episode].
class PlayerConverter {
  /// Creates a new instance of [PlayerConverter].
  const PlayerConverter();

  /// Converts an [AnimeReleaseModel] from the API to a [TitleRelease] domain model.
  ///
  /// Extracts the release alias as UUID, creates a [TitleName] from the release name
  /// (with fallback to '<unknown>' for English name if missing), and converts
  /// all episodes using [episodeFromReleaseEpisodeModel].
  ///
  /// [release] - The anime release model from the API.
  /// Returns a [TitleRelease] domain model.
  TitleRelease releaseFromAnimeRelease(AnimeReleaseModel release) {
    final uuid = release.alias;
    final name = TitleName(
      ru: release.name.main,
      en: release.name.english ?? '<unknown>',
      alternative: release.name.alternative,
    );
    final episodes = release.episodes?.map(episodeFromReleaseEpisodeModel);
    return TitleRelease(
      uuid: uuid,
      name: name,
      episodes: episodes?.toList(growable: false) ?? const [],
    );
  }

  /// Converts an [AnimeReleaseEpisodeModel] from the API to an [Episode] domain model.
  ///
  /// Creates HLS streaming URLs for different quality levels (SD, HD, FHD),
  /// extracts opening and ending skip timestamps if available, and constructs
  /// the episode domain model with all relevant information.
  ///
  /// [value] - The episode model from the API.
  /// Returns an [Episode] domain model.
  Episode episodeFromReleaseEpisodeModel(AnimeReleaseEpisodeModel value) {
    // Create HLS streaming URLs for different quality levels
    final hls = PlayerHls(
      sd: value.hls480,
      hd: value.hls720,
      fhd: value.hls1080,
    );

    Skips? opening;
    Skips? ending;

    // Extract opening skip timestamps if both start and stop are available
    final oStart = value.opening.start;
    final oEnd = value.opening.stop;
    if (oStart != null && oEnd != null) {
      opening = Skips(startSec: oStart, stopSec: oEnd);
    }

    // Extract ending skip timestamps if both start and stop are available
    final eStart = value.ending.start;
    final eEnd = value.ending.stop;
    if (eStart != null && eEnd != null) {
      ending = Skips(startSec: eStart, stopSec: eEnd);
    }

    return Episode(
      name: value.name ?? value.ordinal.toString(),
      uuid: value.id,
      episode: value.ordinal,
      hls: hls,
      opening: opening,
      ending: ending,
      preview: value.preview.src,
    );
  }
}
