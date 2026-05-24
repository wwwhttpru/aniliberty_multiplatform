import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template feed_route}
/// Route configuration for feed tab screens.
///
/// Provides route definitions and utilities for navigating to feed screens.
/// {@endtemplate}
@immutable
class FeedRoute {
  /// Feed tab screen ID.
  final YxRoute feedTab;

  /// Feed screen ID.
  YxRoute get feed => const YxRoute(id: 'feed');

  /// {@macro feed_route}
  const FeedRoute({required this.feedTab});
}
