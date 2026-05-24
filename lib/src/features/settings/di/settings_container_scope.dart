import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/settings/data/data.dart';
import 'package:aniliberty_multiplatform/src/features/settings/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/settings/router/router.dart';
import 'package:aniliberty_multiplatform/src/features/settings/widget/widget.dart';
import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';
import 'package:yx_scope/yx_scope.dart';

/// {@template settings_container_input_scope}
/// Interface for input scope of Settings Container
/// {@endtemplate}
@immutable
final class SettingsContainerInputScope {
  /// App database to use for key-value operations
  final IAppDatabase appDatabase;

  /// Navigation container for registering navigation module
  final ModuleNavigationContainer navigationContainer;

  /// Route resolver for creating NavigationController
  final RouteNodeResolver routeResolver;

  /// {@macro settings_container_input_scope}
  const SettingsContainerInputScope({
    required this.appDatabase,
    required this.navigationContainer,
    required this.routeResolver,
  });
}

/// {@template settings_container_output_scope}
/// Interface for output scope of Settings Container
/// {@endtemplate}
abstract interface class SettingsContainerOutputScope {
  /// Setting theme mode state manager
  abstract final SettingThemeSM themeModeSM;

  /// Setting language state manager
  abstract final SettingLanguageSM languageSM;

  /// Setting video quality state manager
  abstract final SettingVideoQualitySM videoQualitySM;

  /// Settings navigation interactor
  abstract final ISettingsNavigationInteractor navigationInteractor;

  /// General settings widget model
  abstract final IGeneralSettingsWM generalSettingsWM;

  /// Video settings widget model
  abstract final IVideoSettingsWM videoSettingsWM;
}

/// {@template settings_container_scope}
/// Scope for Settings Container
/// {@endtemplate}
class SettingsContainerScope
    extends DataScopeContainer<SettingsContainerInputScope>
    implements SettingsContainerOutputScope {
  @override
  SettingThemeSM get themeModeSM => _themeModeSM.get;

  @override
  SettingLanguageSM get languageSM => _languageSM.get;

  @override
  SettingVideoQualitySM get videoQualitySM => _videoQualitySM.get;

  @override
  ISettingsNavigationInteractor get navigationInteractor =>
      _navigationInteractor.get;

  @override
  IGeneralSettingsWM get generalSettingsWM => _generalSettingsWM.get;

  @override
  IVideoSettingsWM get videoSettingsWM => _videoSettingsWM.get;

  @override
  List<Set<AsyncDep<Object?>>> get initializeQueue => [
    {
      _themeModeSM,
      _languageSM,
      _videoQualitySM,
      _controller,
      _navigationModule,
    },
  ];

  SettingsContainerScope({required super.data});

  /// {@macro i_settings_repository}
  late final _repository = dep<ISettingsRepository>(
    () => SettingsRepository(
      themeModeDB: data.appDatabase.themeMode,
      languageDB: data.appDatabase.language,
      videoQualityDB: data.appDatabase.videoQuality,
    ),
  );

  /// Setting theme mode state manager
  late final _themeModeSM = rawAsyncDep<SettingThemeSM>(
    () => SettingThemeSM(repository: _repository.get),
    init: (value) async => value.init(),
    dispose: (value) async => value.close(),
  );

  /// Setting language state manager
  late final _languageSM = rawAsyncDep<SettingLanguageSM>(
    () => SettingLanguageSM(repository: _repository.get),
    init: (value) async => value.init(),
    dispose: (value) async => value.close(),
  );

  /// Setting video quality state manager
  late final _videoQualitySM = rawAsyncDep<SettingVideoQualitySM>(
    () => SettingVideoQualitySM(repository: _repository.get),
    init: (value) async => value.init(),
    dispose: (value) async => value.close(),
  );

  /// Settings route
  late final _settingsRoute = dep<SettingsRoute>(
    () => const SettingsRoute(),
  );

  /// {@macro yx_navigation_controller}
  late final _controller = rawAsyncDep<NavigationController>(
    () => data.navigationContainer.createNavigationController(
      nodeResolver: data.routeResolver,
    ),
    init: (_) => Future<void>.value(),
    dispose: (value) => value.close(),
  );

  /// {@macro i_settings_navigation_interactor}
  late final _navigationInteractor = dep<ISettingsNavigationInteractor>(
    () => SettingsNavigationInteractor(
      route: _settingsRoute.get,
      controller: _controller.get,
    ),
  );

  /// {@macro settings_navigation_module}
  late final _navigationModule = rawAsyncDep<SettingsNavigationModule>(
    () => SettingsNavigationModule(
      route: _settingsRoute.get,
    ),
    init: (dep) async => data.navigationContainer.register(dep),
    dispose: (dep) async => data.navigationContainer.unregister(dep),
  );

  /// General settings widget model
  late final _generalSettingsWM = dep<IGeneralSettingsWM>(
    () => GeneralSettingsWM(
      themeModeSM: _themeModeSM.get,
      languageSM: _languageSM.get,
    ),
  );

  /// Video settings widget model
  late final _videoSettingsWM = dep<IVideoSettingsWM>(
    () => VideoSettingsWM(videoQualitySM: _videoQualitySM.get),
  );
}

/// {@template settings_container_holder}
/// Holder for Settings Container
/// {@endtemplate}
class SettingsContainerHolder
    extends
        BaseDataScopeHolder<
          SettingsContainerOutputScope,
          SettingsContainerScope,
          SettingsContainerInputScope
        > {
  /// {@macro settings_container_holder}
  SettingsContainerHolder();

  @override
  SettingsContainerScope createContainer(
    SettingsContainerInputScope data,
  ) => SettingsContainerScope(data: data);
}
