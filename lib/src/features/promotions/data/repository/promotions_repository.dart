import 'package:aniliberty_multiplatform/src/datasource_v2/media_promotion/media_promotions_model.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/data/datasource/promotions_remote_db.dart';
import 'package:aniliberty_multiplatform/src/features/promotions/domain/domain.dart';
import 'package:meta/meta.dart';

/// Repository implementation that orchestrates data from remote data sources.
@immutable
final class PromotionsRepository implements IPromotionsRepository {
  /// {@macro i_promotions_remote_db}
  final IPromotionsRemoteDB _remoteDB;

  /// {@macro promotions_repository}
  ///
  /// Creates a new instance of [PromotionsRepository].
  ///
  /// [_remoteDB] - The remote data source for media promotions
  const PromotionsRepository({
    required this._remoteDB,
  });

  @override
  Future<MediaPromotionsModel> readPromotionsFromNetwork() =>
      _remoteDB.promotions();
}
