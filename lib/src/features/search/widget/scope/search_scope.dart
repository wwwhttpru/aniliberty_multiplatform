import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:aniliberty_multiplatform/src/features/search/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/widget_model/search_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class SearchScope extends StatelessWidget {
  final Widget child;

  const SearchScope({
    required this.child,
    super.key,
  });

  static SearchContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<SearchContainerOutputScope>(
      context,
      listen: listen,
    );
    return ArgumentError.checkNotNull(container, 'SearchContainerOutputScope');
  }

  static AnimeSearchSM animeSearchSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).animeSearchSM;

  static IAnimeSearchWM animeSearchWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).animeSearchWM;

  @override
  Widget build(BuildContext context) =>
      ScopeProvider<SearchContainerOutputScope>(
        holder: AppScope.containerOf(context).searchContainerHolder,
        child: ScopeBuilder<SearchContainerOutputScope>.withPlaceholder(
          placeholder: const ProgressLayout(),
          builder: (context, scope) => _Shortcuts(child: child),
        ),
      );
}

class _Shortcuts extends StatelessWidget {
  final Widget child;

  const _Shortcuts({required this.child});

  @override
  Widget build(BuildContext context) => Shortcuts(
    shortcuts: {
      const SingleActivator(LogicalKeyboardKey.slash): VoidCallbackIntent(() {
        onTap(context);
      }),
    },
    child: child,
  );

  void onTap(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    final wm = SearchScope.animeSearchWMOf(
      context,
      listen: false,
    );

    return wm.open();
  }
}
