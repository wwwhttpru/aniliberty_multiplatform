import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';

/// {@template i_promotions_repository}
/// Interface for reading media promotions from the network.
/// {@endtemplate}
abstract interface class IPromotionsRepository {
  /// Returns a list of promotional materials or advertising campaigns
  /// in random order from the network.
  Future<MediaPromotionsModel> readPromotionsFromNetwork();
}
