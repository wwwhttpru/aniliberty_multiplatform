import 'package:meta/meta.dart';
import 'package:yx_navigation/yx_navigation.dart';

/// {@template more_route}
/// Route configuration for more screens.
///
/// Provides route definitions and utilities for navigating to more screens.
/// {@endtemplate}
@immutable
class MoreRoute {
  /// More tab screen ID
  final YxRoute moreTab;

  /// More screen ID
  YxRoute get more => const YxRoute(id: 'more');

  /// {@macro more_route}
  const MoreRoute({required this.moreTab});
}
