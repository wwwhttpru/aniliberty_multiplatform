import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/genres/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/common/genre_grid_item.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/common/genre_grid_progress_item.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/genres/widget/widget_model/genres_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  /// {@macro genres_wm}
  late final IGenresWM _genresWM;

  @override
  void initState() {
    super.initState();
    _genresWM = GenresScope.genresWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _genresWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: BackButton(onPressed: _onClose),
      title: const Text('Жанры'),
    ),
    body: GenresStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const _ProgressLayout(),
          success: (success) => _SuccessLayout(success.animeGenres),
          error: (_) => ErrorLayout(onTap: _genresWM.read),
        ),
      ),
    ),
  );

  void _onClose() => _genresWM.closeGenres();
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout() : super(key: const Key('genre_grid_progress_layout'));

  @override
  Widget build(BuildContext context) => GridView.builder(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    padding: context.spacingAll,
    gridDelegate: _SuccessLayout.gridDelegate,
    itemBuilder: (context, index) => GenreGridProgressItem(
      key: ValueKey('genre_grid_progress_item_$index'),
    ),
    itemCount: 20,
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeGenresModel animeGenres;

  const _SuccessLayout(this.animeGenres);

  /// Shared grid delegate for the genre grid.
  static const gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 9 / 16,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context) => GridView.builder(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    padding: context.spacingAll,
    gridDelegate: gridDelegate,
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
    final wm = GenresScope.genresWMOf(
      context,
      listen: false,
    );

    return wm.openGenre(genreId);
  }
}
