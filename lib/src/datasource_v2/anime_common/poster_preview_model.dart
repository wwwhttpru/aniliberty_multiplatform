// ignore_for_file: always_put_required_named_parameters_first

import 'package:freezed_annotation/freezed_annotation.dart';

part 'poster_preview_model.freezed.dart';
part 'poster_preview_model.g.dart';

/// Poster preview model
@freezed
abstract class PosterPreviewModel with _$PosterPreviewModel {
  const PosterPreviewModel._();

  String? get src => origin ?? preview;

  const factory PosterPreviewModel({
    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__231400294e84de4d2ef108eb034c7cce.webp
    @JsonKey(name: 'preview') String? preview,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__231400294e84de4d2ef108eb034c7cce.webp
    @JsonKey(name: 'src') String? origin,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__3970bbec8d96605f60e92d1af21be963.jpg
    @JsonKey(name: 'thumbnail') String? thumbnail,

    /// Оптимизированный постер
    @JsonKey(name: 'optimized') required PosterPreviewOptimizedModel optimized,
  }) = _PosterPreviewModel;

  /// Generate Class from Map<String, Object?>
  factory PosterPreviewModel.fromJson(Map<String, Object?> json) =>
      _$PosterPreviewModelFromJson(json);
}

@freezed
abstract class PosterPreviewOptimizedModel with _$PosterPreviewOptimizedModel {
  const PosterPreviewOptimizedModel._();

  String? get src => origin ?? preview;

  const factory PosterPreviewOptimizedModel({
    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__231400294e84de4d2ef108eb034c7cce.webp
    @JsonKey(name: 'preview') String? preview,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__231400294e84de4d2ef108eb034c7cce.webp
    @JsonKey(name: 'src') String? origin,

    /// example: /storage/releases/posters/7439/QdCyM3mdXsUIfXtR__754b7d4317b2760d5ddadcb0ad01501e.webp
    @JsonKey(name: 'thumbnail') String? thumbnail,
  }) = _PosterPreviewOptimizedModel;

  /// Generate Class from Map<String, Object?>
  factory PosterPreviewOptimizedModel.fromJson(Map<String, Object?> json) =>
      _$PosterPreviewOptimizedModelFromJson(json);
}
