import 'package:meta/meta.dart';

abstract interface class AppUrlConfig {
  /// Url for backend
  abstract final String anilibria;

  /// Url for storage
  abstract final String storage;

  /// List of available sources
  ///
  /// See [AppSourceUrl] for more information.
  abstract final List<AppSourceUrl> sources;

  /// Url for sign up
  abstract final String signUp;

  /// Url for author
  abstract final String author;

  /// Url for bug report
  abstract final String bugReport;

  /// Url for technical support
  abstract final String technicalSupport;
}

/// {@template app_source_url}
/// URL configuration for the app
/// {@endtemplate}
@immutable
final class AppSourceUrl {
  /// Base URL for the API
  final String baseUrl;

  /// Storage URL
  final String storageUrl;

  /// {@macro app_source_url}
  const AppSourceUrl({
    required this.baseUrl,
    required this.storageUrl,
  });
}

@immutable
final class AppUrlConfigImpl implements AppUrlConfig {
  @override
  String get anilibria => 'https://aniliberty.top/api/v1';

  @override
  String get storage => 'https://static.wwnd.space';

  @override
  List<AppSourceUrl> get sources => const [
    AppSourceUrl(
      baseUrl: 'https://www.anilibria.top/api/v1',
      storageUrl: 'https://static.wwnd.space',
    ),
    AppSourceUrl(
      baseUrl: 'https://api.anilibria.app/api/v1',
      storageUrl: 'https://aniliberty.top',
    ),
    AppSourceUrl(
      baseUrl: 'https://aniliberty.top/api/v1',
      storageUrl: 'https://aniliberty.top',
    ),
  ];

  @override
  String get signUp =>
      'https://anilibria.top/app/auth/registration/newRegistration';

  @override
  String get author => 'https://t.me/wwwhttpru';

  @override
  String get bugReport =>
      'https://github.com/wwwhttpru/aniliberty_multiplatform/issues';

  @override
  String get technicalSupport => 'https://t.me/Libria911Bot';

  const AppUrlConfigImpl();
}
