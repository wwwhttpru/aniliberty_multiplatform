import 'package:aniliberty_multiplatform/src/common/common.dart';
import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/genres/di/di.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget_model/genre_releases_wm.dart';
import 'package:flutter/material.dart';
import 'package:yx_scope_flutter/yx_scope_flutter.dart';

class GenreReleasesScope extends StatefulWidget {
  /// {@macro genre_releases_holder_factory}
  final IGenreReleasesHolderFactory holderFactory;

  /// Genre identifier.
  final int genreId;

  /// Child widget.
  final Widget child;

  const GenreReleasesScope({
    required this.holderFactory,
    required this.genreId,
    required this.child,
    super.key,
  });

  static GenreReleasesContainerOutputScope containerOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final container = ScopeProvider.of<GenreReleasesContainerOutputScope>(
      context,
      listen: listen,
    );

    return ArgumentError.checkNotNull(
      container,
      'GenreReleasesContainerOutputScope',
    );
  }

  static IGenreReleasesWM genreReleasesWMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).genreReleasesWM;

  static GenreReleasesSM genreReleasesSMOf(
    BuildContext context, {
    bool listen = true,
  }) => containerOf(context, listen: listen).genreReleasesSM;

  @override
  State<GenreReleasesScope> createState() => _GenreReleasesScopeState();
}

class _GenreReleasesScopeState extends State<GenreReleasesScope> {
  late final GenreReleasesContainerHolder _holder;
  late final GenreReleasesContainerInputScope _inputScope;

  @override
  void initState() {
    super.initState();
    _holder = widget.holderFactory.create();
    _inputScope = widget.holderFactory.createInputScope(
      genreId: widget.genreId,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _holder.create(_inputScope);
    });
  }

  @override
  void dispose() {
    _holder.drop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // TODO(wwwhttpru): refactor
      ScopeProvider<GenreReleasesContainerOutputScope>(
        holder: _holder,
        child: ScopeBuilder<GenreReleasesContainerOutputScope>(
          holder: _holder,
          builder: (context, scope) => ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: AnimateSwitchLayout(
              child: switch (scope) {
                GenreReleasesContainerOutputScope() => widget.child,
                null => const ScopeProgressLayout(key: ValueKey('progress')),
              },
            ),
          ),
        ),
      );
}
