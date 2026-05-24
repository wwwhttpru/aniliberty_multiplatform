import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget_model/genre_releases_wm.dart';

import 'package:aniliberty_multiplatform/src/features/release/release.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GenreReleasesScreen extends StatefulWidget {
  const GenreReleasesScreen({super.key});

  @override
  State<GenreReleasesScreen> createState() => _GenreReleasesScreenState();
}

class _GenreReleasesScreenState extends State<GenreReleasesScreen> {
  /// {@macro genre_releases_wm}
  late final IGenreReleasesWM _genreReleasesWM;

  /// Scroll controller.
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _genreReleasesWM = GenreReleasesScope.genreReleasesWMOf(
      context,
      listen: false,
    );
    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _genreReleasesWM.onScrollList();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // TODO(wwwhttpru): fix body layout
  @override
  Widget build(BuildContext context) => Scaffold(
    body: GenreReleasesStateBuilder(
      builder: (context, state, _) {
        if (state.isProgress && state.release.isEmpty) {
          return const ProgressLayout();
        }

        if (state.isError && state.release.isEmpty) {
          return ErrorLayout(onTap: _genreReleasesWM.onScrollList);
        }

        return CustomScrollView(
          scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: context.spacingAll.copyWith(bottom: 16),
              sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
            ),
            SliverPadding(
              padding: context.spacingH.copyWith(bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Релизы жанра',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPadding(
              padding: context.spacingH,
              sliver: _ListLayout(
                scrollController: _scrollController,
                animeReleases: state.release,
              ),
            ),
            SliverPadding(
              padding: context.spacingAll.copyWith(top: 16),
              sliver: const SliverToBoxAdapter(),
            ),
          ],
        );
      },
    ),
  );

  void _onScroll() {
    if (!_isBottom) return;
    _genreReleasesWM.onScrollList();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _ListLayout extends StatelessWidget {
  final ScrollController scrollController;
  final List<AnimeReleaseModel> animeReleases;

  const _ListLayout({
    required this.scrollController,
    required this.animeReleases,
  });

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 9 / 16,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
    ),
    itemBuilder: (context, index) {
      final value = animeReleases[index];
      return ReleaseGridItem(key: ValueKey(value.id), animeRelease: value);
    },
    itemCount: animeReleases.length,
  );
}
