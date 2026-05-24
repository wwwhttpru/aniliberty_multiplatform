import 'package:aniliberty_multiplatform/src/features/release/router/release_route.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/video_player.dart';
import 'package:yx_navigation/yx_navigation.dart';

abstract interface class IReleasesNavigationInteractor {
  /// Открыть релиз из корня
  ///
  /// [aliasOrId] - алиас или идентификатор релиза
  void openRelease(String aliasOrId);

  /// Открыть все последние релизы
  void openLatestAll();

  /// Открыть эпизод
  void openEpisode(String episodeId);
}

class ReleasesNavigationInteractor implements IReleasesNavigationInteractor {
  final NavigationController _releasesController;
  final NavigationController _releaseController;
  final IVideoPlayerNavigationInteractor _playerNavigationInteractor;
  final ReleaseRoute _route;

  const ReleasesNavigationInteractor({
    required this._releasesController,
    required this._releaseController,
    required this._playerNavigationInteractor,
    required this._route,
  });

  @override
  void openRelease(String aliasOrId) {
    assert(aliasOrId.isNotEmpty, 'AliasOrId must not be empty');
    _releaseController.push(
      _route.release,
      arguments: {_route.releaseAliasOrId: aliasOrId},
    );
  }

  @override
  void openLatestAll() {
    final route = _route.releaseLatestAll;

    final routeNode = _releasesController.state?.findByRoute(route);
    if (routeNode != null) {
      return;
    }

    _releasesController.push(route);
  }

  @override
  void openEpisode(String episodeId) =>
      _playerNavigationInteractor.openVideoPlayer(episodeId);
}
