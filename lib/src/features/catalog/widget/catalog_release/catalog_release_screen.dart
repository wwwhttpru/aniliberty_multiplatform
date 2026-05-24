import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_release/catalog_release_list_item.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_release/catalog_search_field.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/consumer/catalog_release_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget_model/catalog_release_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CatalogReleaseScreen extends StatelessWidget {
  const CatalogReleaseScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Каталог релизов')),
    body: const _BodyLayout(),
  );
}

class _BodyLayout extends StatefulWidget {
  const _BodyLayout();

  @override
  State<_BodyLayout> createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<_BodyLayout> {
  late final ICatalogReleaseWM _catalogReleaseWM;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _catalogReleaseWM = CatalogScope.catalogReleaseWMOf(context, listen: false);
    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _catalogReleaseWM.onReadReleases();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CatalogReleaseStateBuilder(
    builder: (context, state, _) {
      final body = state.toLayout(
        fatalError: () => const _FatalErrorLayout(),
        initial: () => const _ProgressLayout(),
        empty: () => const _EmptyLayout(),
        data: () => _DataLayout(state.release),
      );

      return CustomScrollView(
        scrollCacheExtent: ScrollCacheExtent.pixels(
          CatalogReleaseListItem.height * 10,
        ),
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(child: CatalogSearchField()),
          body,
          _PaginationIndicator(
            isProgress: state.isProgress,
            hasData: state.release.isNotEmpty,
          ),
        ],
      );
    },
  );

  void _onScroll() {
    if (!_isBottom) return;
    _catalogReleaseWM.onScrollList();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class _FatalErrorLayout extends StatelessWidget {
  const _FatalErrorLayout();

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
    child: ErrorLayout(onTap: () => _onTap(context)),
    hasScrollBody: false,
  );

  void _onTap(BuildContext context) => CatalogScope.catalogReleaseWMOf(
    context,
    listen: false,
  ).onReadReleases();
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout();

  @override
  Widget build(BuildContext context) => const SliverFillRemaining(
    child: ProgressLayout(),
    hasScrollBody: false,
  );
}

class _DataLayout extends StatelessWidget {
  final List<AnimeReleaseModel> releases;

  const _DataLayout(this.releases);

  @override
  Widget build(BuildContext context) => SliverList.separated(
    itemCount: releases.length,
    itemBuilder: (context, index) {
      final animeRelease = releases[index];
      return CatalogReleaseListItem(
        animeRelease: animeRelease,
        key: ValueKey(animeRelease.alias),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(height: 16),
  );
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PlaceholderImage(height: 150, width: 150),
        Text(
          'Ни одного релиза',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          'По вашим параметрам не найдено ни одного релиза',
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
    hasScrollBody: false,
  );
}

class _PaginationIndicator extends StatelessWidget {
  final bool isProgress;
  final bool hasData;

  const _PaginationIndicator({required this.isProgress, required this.hasData});

  @override
  Widget build(BuildContext context) {
    if (isProgress && hasData) {
      return const SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 12),
        sliver: SliverToBoxAdapter(child: ProgressLayout()),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}

extension on CatalogReleaseState {
  Widget toLayout({
    required Widget Function() fatalError,
    required Widget Function() initial,
    required Widget Function() empty,
    required Widget Function() data,
  }) {
    if (isFatal) {
      return fatalError();
    }

    // Данных нету
    final isEmpty = release.isEmpty;
    final isInitial = pagination.isInitial;

    // Начальное состояние
    if (isIdle && isInitial) {
      return initial();
    }

    // Начальная загрузка данных
    if (isProgress && isEmpty && !isInitial) {
      return initial();
    }

    // Данных нету
    if (isIdle && isEmpty && pagination.isEndOfPage) {
      return empty();
    }

    return data();
  }
}
