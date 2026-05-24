import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:meta/meta.dart';

/// Interface for fetching media promotions from the remote API.
abstract interface class IPromotionsRemoteDB {
  /// Returns a list of promotional materials or advertising campaigns in random order.
  Future<MediaPromotionsModel> promotions();
}

/// Remote data source for media promotions.
///
/// For more information about the API, see <https://anilibria.top/api/docs/v1#/>.
@immutable
final class PromotionsRemoteDB implements IPromotionsRemoteDB {
  /// {@macro app_network}
  final AppNetwork _appNetwork;

  /// {@macro i_promotions_remote_db}
  ///
  /// Creates a new instance of [PromotionsRemoteDB].
  ///
  /// [_appNetwork] - The network client for API requests
  const PromotionsRemoteDB({
    required this._appNetwork,
  });

  @override
  Future<MediaPromotionsModel> promotions() async {
    final response = await _appNetwork.coreV2.get<List<Object?>>(
      '/media/promotions',
    );

    final data = ArgumentError.checkNotNull(response.data, 'response');
    return MediaPromotionsModel.fromJson({'promotions': data});
  }
}
