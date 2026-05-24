import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/episode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'title_release.freezed.dart';

/// Represents a title release with its metadata and episodes.
///
/// A title release contains information about an anime title including
/// its unique identifier, name in different languages, and a list of
/// available episodes.
@freezed
abstract class TitleRelease with _$TitleRelease {
  const factory TitleRelease({
    /// Unique identifier of the title
    required String uuid,

    /// Title name in different languages
    required TitleName name,

    /// List of episodes available for this title
    required List<Episode> episodes,
  }) = _TitleRelease;
}

/// Represents the name of a title in different languages.
///
/// Contains the title name in Russian, English, and optionally
/// an alternative name.
@freezed
abstract class TitleName with _$TitleName {
  const factory TitleName({
    /// Russian title name
    required String ru,

    /// English title name
    required String en,

    /// Alternative title name
    required String? alternative,
  }) = _TitleName;
}
