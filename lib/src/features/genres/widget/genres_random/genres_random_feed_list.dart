import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/feed/feed.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/common/genre_grid_item.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/common/genre_grid_progress_item.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget_model/genres_random_wm.dart';
import 'package:flutter/material.dart';

class GenresRandomFeedList extends StatefulWidget {
  const GenresRandomFeedList({super.key});

  @override
  State<GenresRandomFeedList> createState() => _GenresRandomFeedListState();
}

class _GenresRandomFeedListState extends State<GenresRandomFeedList> {
  /// {@macro genres_random_wm}
  late final IGenresRandomWM _genresRandomWM;

  @override
  void initState() {
    super.initState();
    _genresRandomWM = GenresScope.genresRandomWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _genresRandomWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => FeedCategoryItem(
    title: 'Жанры',
    subtitle: 'Список жанров на любой вкус и цвет',
    onTap: _genresRandomWM.openGenres,
    child: GenresRandomStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const _ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeGenres),
          error: (_) => ErrorLayout(onTap: _genresRandomWM.read),
        ),
      ),
    ),
  );
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout() : super(key: const Key('genre_grid_progress_layout'));

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemBuilder: (context, index) => GenreGridProgressItem(
      key: ValueKey('genre_grid_progress_item_$index'),
    ),
    itemCount: 20,
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeGenresModel animeGenres;

  const _SuccessLayout(this.animeGenres);

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemBuilder: (context, index) {
      final value = animeGenres.genres[index];
      return GenreGridItem(
        key: ValueKey(value.id),
        animeGenre: value,
        onTap: () => _onTap(context, value.id),
      );
    },
    itemCount: animeGenres.genres.length,
  );

  void _onTap(BuildContext context, int genreId) {
    final wm = GenresScope.genresRandomWMOf(
      context,
      listen: false,
    );

    return wm.openGenre(genreId);
  }
}

class _HorizontalListLayout extends StatelessWidget {
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;

  const _HorizontalListLayout({
    required this.itemBuilder,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    scrollDirection: Axis.horizontal,
    padding: context.spacingH,
    itemCount: itemCount,
    itemBuilder: (context, index) {
      final child = itemBuilder(context, index);
      return SizedBox(width: 180, child: child);
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: FeedCategoryItem.hPadding,
    ),
  );
}
