import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_common_pagination_model.freezed.dart';
part 'anime_common_pagination_model.g.dart';

@freezed
abstract class AnimeCommonPaginationModel with _$AnimeCommonPaginationModel {
  const AnimeCommonPaginationModel._();

  /// Возвращает истину, если текущая страница конечная
  bool get isEndOfPage => currentPage >= totalPages;

  /// Возвращает истину если текущая страница начальная
  bool get isInitial => currentPage == 0;

  /// Возвращает номер следующей страницы
  int get nextPage => currentPage + 1;

  const factory AnimeCommonPaginationModel({
    /// example: 1704
    @JsonKey(name: 'total') required int total,

    /// example: 10
    @JsonKey(name: 'count') required int count,

    /// example: 10
    @JsonKey(name: 'per_page') required int perPage,

    /// example: 5
    @JsonKey(name: 'current_page') required int currentPage,

    /// example: 171
    @JsonKey(name: 'total_pages') required int totalPages,

    // links
  }) = _AnimeCommonPaginationModel;

  static const AnimeCommonPaginationModel initial = AnimeCommonPaginationModel(
    total: 9999,
    count: 0,
    perPage: 0,
    currentPage: 0,
    totalPages: 9999,
  );

  /// Generate Class from Map<String, Object?>
  factory AnimeCommonPaginationModel.fromJson(Map<String, Object?> json) =>
      _$AnimeCommonPaginationModelFromJson(json);
}
