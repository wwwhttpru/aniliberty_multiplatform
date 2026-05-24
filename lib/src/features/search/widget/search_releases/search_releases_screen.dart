import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/search/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/consumer/anime_search_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/scope/search_scope.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/search_releases/search_release_list_item.dart';
import 'package:aniliberty_multiplatform/src/features/search/widget/search_releases/search_release_text_field.dart';
import 'package:flutter/material.dart';

class SearchReleasesScreen extends StatelessWidget {
  const SearchReleasesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Поиск релизов'),
      forceMaterialTransparency: true,
      leading: CloseButton(onPressed: () => _onClose(context)),
    ),
    body: const Column(
      children: [
        _SearchLayout(),
        Expanded(child: _BodyLayout()),
      ],
    ),
  );

  void _onClose(BuildContext context) {
    final wm = SearchScope.animeSearchWMOf(
      context,
      listen: false,
    );
    return wm.close();
  }
}

class _SearchLayout extends StatelessWidget {
  const _SearchLayout();

  @override
  Widget build(BuildContext context) {
    final padding = context.spacingHOrSa;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: padding.copyWith(bottom: 8),
        child: const SearchReleaseTextField(),
      ),
    );
  }
}

class _BodyLayout extends StatelessWidget {
  const _BodyLayout();

  @override
  Widget build(BuildContext context) => AnimeSearchStateBuilder(
    builder: (context, state, _) => AnimateSwitchLayout(
      child: state.map<Widget>(
        idle: (_) => const _PlaceholderLayout(),
        progress: (_) => const Center(child: ProgressLayout()),
        success: (value) => _SuccessLayout(value.animeSearch),
        error: (_) => const _EmptyLayout(),
      ),
    ),
  );
}

class _PlaceholderLayout extends StatelessWidget {
  const _PlaceholderLayout();

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.spacingAllOrSa,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PlaceholderImage(height: 150, width: 150),
        Text(
          'Введите название релиза',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          'Результат вашего поиска появится здесь',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeSearchModel animeSearch;

  const _SuccessLayout(this.animeSearch);

  @override
  Widget build(BuildContext context) {
    if (animeSearch.releases.isEmpty) {
      return const _EmptyLayout();
    }

    return ListView.separated(
      clipBehavior: Clip.antiAlias,
      padding: context.spacingAllOrSa,
      itemBuilder: (context, index) {
        final animeRelease = animeSearch.releases[index];
        return SearchReleaseListItem(animeRelease: animeRelease);
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: animeSearch.releases.length,
    );
  }
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.spacingAllOrSa,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PlaceholderImage(height: 150, width: 150),
        Text(
          'Нет подходящих релизов',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          'По данному поисковому запросу не найден ни один релиз',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
