import 'package:freezed_annotation/freezed_annotation.dart';

part 'tab_bar_state.freezed.dart';

/// {@template tab_bar_tab}
/// Available tabs in the tab bar
/// {@endtemplate}
enum TabBarTab { feed, catalog, more }

/// {@template tab_bar_state}
/// State for the tab bar
/// {@endtemplate}
@freezed
abstract class TabBarState with _$TabBarState {
  /// {@macro tab_bar_state}
  const factory TabBarState({
    /// Active tab
    required TabBarTab active,

    /// All tabs
    required List<TabBarTab> tabs,
  }) = _TabBarState;
}
