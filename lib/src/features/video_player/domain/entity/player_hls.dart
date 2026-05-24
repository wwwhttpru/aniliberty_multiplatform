import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_hls.freezed.dart';

/// HLS (HTTP Live Streaming) player data with different quality options.
///
/// Contains streaming URLs for different video quality levels:
/// - FHD (Full HD): 1080p quality
/// - HD: 720p quality
/// - SD: Standard definition quality
///
/// All fields are optional, allowing fallback to lower quality if higher
/// quality is not available.
@freezed
abstract class PlayerHls with _$PlayerHls {
  const factory PlayerHls({
    /// Streaming URL for Full-HD (1080p) quality
    required String? fhd,

    /// Streaming URL for HD (720p) quality
    required String? hd,

    /// Streaming URL for SD (standard definition) quality
    required String? sd,
  }) = _PlayerHls;
}
