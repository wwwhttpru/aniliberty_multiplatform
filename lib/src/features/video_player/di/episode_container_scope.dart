import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_scope/yx_scope.dart';

abstract interface class EpisodeContainerOutputScope {
  ///
  /// * Domain *
  ///

  abstract final TitleEpisodeSM titleEpisodeSM;
  abstract final VideoPlayerControllerManager controllerSM;
  abstract final VideoPlayerInfoSM infoSM;
  abstract final VideoQualitySM videoQualitySM;
  abstract final IFullScreenService fullScreenService;

  ///
  /// * Widget *
  ///

  abstract final IVideoPlayerControlWM controlWM;
  abstract final IEpisodesWM episodesWM;
  abstract final ISettingsWM settingsWM;
  abstract final IVideoShortcuts shortcuts;
}

abstract interface class EpisodeContainerInputFactory {
  /// Create input scope for Episode Container
  ///
  /// [episodeId] - ID of the episode
  EpisodeContainerInputScope create(String episodeId);
}

@immutable
class EpisodeContainerInputScope {
  /// Required for network operations
  final AppNetwork appNetwork;

  /// Video player repository
  final IVideoPlayerRepository repository;

  /// Navigation interactor
  final IVideoPlayerNavigationInteractor navigationInteractor;

  /// Episode identifier
  final String episodeId;

  const EpisodeContainerInputScope({
    required this.appNetwork,
    required this.repository,
    required this.navigationInteractor,
    required this.episodeId,
  });

  @override
  int get hashCode => episodeId.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is EpisodeContainerInputScope && episodeId == other.episodeId;
  }
}

class EpisodeContainerScope
    extends DataScopeContainer<EpisodeContainerInputScope>
    implements EpisodeContainerOutputScope {
  @override
  TitleEpisodeSM get titleEpisodeSM => _titleEpisodeSM.get;

  @override
  VideoPlayerControllerManager get controllerSM => _controllerSM.get;

  @override
  VideoPlayerInfoSM get infoSM => _infoSM.get;

  @override
  VideoQualitySM get videoQualitySM => _videoQualitySM.get;

  @override
  IVideoPlayerControlWM get controlWM => _controlWM.get;

  @override
  IEpisodesWM get episodesWM => _episodesWM.get;

  @override
  ISettingsWM get settingsWM => _settingsWM.get;

  @override
  IVideoShortcuts get shortcuts => _shortcuts.get;

  @override
  IFullScreenService get fullScreenService => _fullScreenService.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {_titleEpisodeSM, _videoQualitySM, _controllerSM},
    {_infoSM, _fullScreenService},
    {_episodeInteractor, _settingsWM, _shortcuts},
  ];

  EpisodeContainerScope({required super.data});

  late final _episodeInteractor = rawAsyncDep<PlayerEpisodeInteractor>(
    () => PlayerEpisodeInteractor(
      titleEpisodeSM: _titleEpisodeSM.get,
      videoQualitySM: _videoQualitySM.get,
      videoPlayerInfoSM: _infoSM.get,
      controllerManager: _controllerSM.get,
    ),
    init: (value) => value.initialize(),
    dispose: (value) => value.close(),
  );

  late final _titleEpisodeSM = rawAsyncDep(
    () => TitleEpisodeSM(
      episodeId: data.episodeId,
      repository: data.repository,
    ),
    init: (value) async => value.read(),
    dispose: (value) => value.close(),
  );

  late final _controllerSM = rawAsyncDep<VideoPlayerControllerManager>(
    VideoPlayerControllerManager.new,
    init: (value) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  late final _infoSM = rawAsyncDep(
    () => VideoPlayerInfoSM(
      controllerReadable: _controllerSM.get,
    ),
    init: (value) => value.initialize(),
    dispose: (value) => value.close(),
  );

  late final _videoQualitySM = rawAsyncDep(
    () => VideoQualitySM(repository: data.repository),
    init: (value) async => value.read(),
    dispose: (value) => value.close(),
  );

  late final _controlWM = dep(
    () => VideoPlayerControlWM(
      controllerSM: _controllerSM.get,
      titleEpisodeSM: _titleEpisodeSM.get,
      fullScreenService: _fullScreenService.get,
    ),
  );

  late final _episodesWM = dep(
    () => EpisodesWM(
      episodeSM: _titleEpisodeSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
  );

  late final _settingsWM = rawAsyncDep(
    () => SettingsWM(
      videoQualitySM: _videoQualitySM.get,
      titleEpisodeSM: _titleEpisodeSM.get,
      navigationInteractor: data.navigationInteractor,
    ),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  late final _shortcuts = rawAsyncDep(
    () => VideoShortcuts(controlWM: _controlWM.get),
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );

  late final _fullScreenService = rawAsyncDep(
    createFullScreenService,
    init: (value) => value.init(),
    dispose: (value) => value.dispose(),
  );
}

class EpisodeContainerHolder
    extends
        BaseDataScopeHolder<
          EpisodeContainerOutputScope,
          EpisodeContainerScope,
          EpisodeContainerInputScope
        > {
  @override
  EpisodeContainerScope createContainer(
    EpisodeContainerInputScope data,
  ) => EpisodeContainerScope(data: data);
}
