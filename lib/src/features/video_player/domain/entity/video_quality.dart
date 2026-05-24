import 'package:aniliberty_multiplatform/src/features/video_player/domain/entity/player_hls.dart';

/// {@template video_quality}
/// Video quality enum
/// {@endtemplate}
enum VideoQuality {
  /// Full HD (1080p) quality
  fhd('fhd'),

  /// HD (720p) quality
  hd('hd'),

  /// SD (standard definition) quality
  sd('sd');

  /// Get the name of the quality
  String get name => switch (this) {
    fhd => '1080p',
    hd => '720p',
    sd => '480p',
  };

  /// Whether the quality is available in the given HLS
  ///
  /// Use this to determine if the quality is available in the given HLS
  bool hasQualityByHls(PlayerHls hls) => switch (this) {
    fhd => hls.fhd != null,
    hd => hls.hd != null,
    sd => hls.sd != null,
  };

  /// {@macro video_quality}
  const VideoQuality(this.code);

  /// Code of the quality
  final String code;
}
