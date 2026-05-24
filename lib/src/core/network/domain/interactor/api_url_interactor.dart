import 'package:aniliberty_multiplatform/src/core/config/config.dart';
import 'package:aniliberty_multiplatform/src/core/monitoring/monitoring.dart';
import 'package:aniliberty_multiplatform/src/core/network/domain/entity/api_base_url_state.dart';
import 'package:collection/collection.dart';

/// {@template api_url_interactor}
/// Interface for managing API base URLs.
///
/// This interactor is responsible for managing the base URLs of the API.
/// It is used to switch to the next base URL if the current one is failed.
/// It is also used to mark the base URL as successful or failed.
///
/// {@endtemplate}
abstract interface class IApiUrlInteractor {
  /// Current active base URL.
  String get activeBaseUrl;

  /// Mark base URL as successful.
  void markAsSuccessBaseUrl(String baseUrl);

  /// Mark base URL as failed.
  void markAsFailedBaseUrl(String baseUrl);

  /// Check if the base URL should be switched to the next one.
  ///
  /// If method returns `true`, the base URL should be switched to the next one.
  /// You can get the next base URL using [activeBaseUrl] property.
  ///
  /// If method returns `false`, the base URL should not be switched
  /// to the next one.
  bool shouldSwitchToNextBaseUrl(String failedBaseUrl);
}

/// {@template api_url_interactor}
/// Interactor for API URL
/// {@endtemplate}
class ApiUrlInteractor implements IApiUrlInteractor {
  /// {@macro logger}
  final Logger _logger;

  /// {@macro app_url_config}
  final AppUrlConfig _appUrlConfig;

  /// List of base URL states.
  final Map<String, ApiBaseUrlState> _baseUrlStates;

  /// Current active base URL.
  ///
  /// Initial value is [AppUrlConfig.anilibria].
  String _activeBaseUrl;

  /// Current active base URL.
  @override
  String get activeBaseUrl => _activeBaseUrl;

  /// {@macro api_url_interactor}
  ApiUrlInteractor({
    required this._logger,
    required AppUrlConfig appUrlConfig,
  }) : _appUrlConfig = appUrlConfig,
       _baseUrlStates = <String, ApiBaseUrlState>{}, // mutable map
       _activeBaseUrl = appUrlConfig.anilibria;

  /// Initialize the API URL interactor.
  Future<void> init() async {
    // Make base URL states.
    _makeBaseUrlStates(_appUrlConfig.sources);
    _logger.debug('API URL interactor initialized');
    return Future<void>.value();
  }

  /// Dispose the API URL interactor.
  Future<void> dispose() async {
    _baseUrlStates.clear();
    _activeBaseUrl = _appUrlConfig.anilibria;
    return Future<void>.value();
  }

  /// Set successful base URL.
  @override
  void markAsSuccessBaseUrl(String baseUrl) {
    _logger.debug('Base URL marked as successful: $baseUrl');
    _baseUrlStates[baseUrl] = ApiBaseUrlState(
      baseUrl: baseUrl,
      status: ApiBaseUrlStatus.success,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  /// Set failed base URL.
  @override
  void markAsFailedBaseUrl(String baseUrl) {
    _logger.debug('Base URL marked as failed: $baseUrl');
    _baseUrlStates[baseUrl] = ApiBaseUrlState(
      baseUrl: baseUrl,
      status: ApiBaseUrlStatus.failed,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  /// Check if the base URL should be switched to the next one.
  @override
  bool shouldSwitchToNextBaseUrl(String failedBaseUrl) {
    // If the failed base URL is not the current active base URL,
    // that means the base URL already switched to the next one.
    if (failedBaseUrl != _activeBaseUrl) {
      return true;
    }

    final states = _baseUrlStates.values;

    // Search successful base URL. If successful base URL is found,
    // try to search unknown base URL. If unknown base URL is found,
    // return false.
    final successfulBaseUrl = states.firstWhereOrNull(
      (state) => state.status.isSuccess,
    );

    // If successful base URL is found, switch to it.
    if (successfulBaseUrl != null) {
      _activeBaseUrl = successfulBaseUrl.baseUrl;
      return true;
    }

    // Search failed base URL. If failed base URL is found,
    // and it is older than 5 minutes, switch to it.
    final maybeFailedBaseUrl = states.firstWhereOrNull(
      (state) {
        if (!state.status.isFailed) {
          return false;
        }
        final now = DateTime.now().toUtc();
        final updatedAt = state.updatedAt;
        final difference = now.difference(updatedAt);
        return difference.inMinutes > 5;
      },
    );

    // If failed base URL is found, switch to it and mark it as unknown.
    if (maybeFailedBaseUrl != null) {
      _logger.debug(
        'Switching to failed base URL: ${maybeFailedBaseUrl.baseUrl}',
      );
      _baseUrlStates[maybeFailedBaseUrl.baseUrl] = ApiBaseUrlState(
        baseUrl: maybeFailedBaseUrl.baseUrl,
        status: ApiBaseUrlStatus.unknown,
        updatedAt: DateTime.now().toUtc(),
      );
      _activeBaseUrl = maybeFailedBaseUrl.baseUrl;
      return true;
    }

    // Search unknown base URL. If unknown base URL is found,
    // return true.
    final unknownBaseUrl = states.firstWhereOrNull(
      (state) => state.status.isUnknown,
    );

    // If unknown base URL is found, switch to it.
    if (unknownBaseUrl != null) {
      _activeBaseUrl = unknownBaseUrl.baseUrl;
      return true;
    }

    return false;
  }

  /// Make base URL states.
  void _makeBaseUrlStates(List<AppSourceUrl> sources) {
    // Copy base URL states to a new map.
    final states = Map.of(_baseUrlStates);

    // Update base URL states or create new ones.
    for (final source in sources) {
      final state = states[source.baseUrl];

      // If state is already exists, skip it.
      if (state != null) {
        states.remove(source.baseUrl);
        continue;
      }

      // Create new state.
      _baseUrlStates[source.baseUrl] = ApiBaseUrlState(
        baseUrl: source.baseUrl,
        status: ApiBaseUrlStatus.unknown,
        updatedAt: DateTime.now().toUtc(),
      );
      states.remove(source.baseUrl);
    }

    // If states are not empty, that means there are unknown URLs that
    // are not in the new list. So we need to remove them.
    for (final state in states.values) {
      // If unknown URL is successful, skip it.
      if (state.status.isSuccess) {
        continue;
      }

      // Remove unknown URL.
      _baseUrlStates.remove(state.baseUrl);
      _logger.debug('Base URL state removed: ${state.baseUrl}');
    }

    _logger.debug('Base URL states made: ${_baseUrlStates.keys}');
  }
}
