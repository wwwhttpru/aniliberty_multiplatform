import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_filter/catalog_filter_list_item.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_filter/filter_chips_item.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_filter/filter_radio_item.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/catalog_filter/filter_slider_item.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/consumer/catalog_filter_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/consumer/catalog_references_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget_model/catalog_filter_wm.dart';
import 'package:flutter/material.dart';

class CatalogFilterSheet extends StatefulWidget {
  const CatalogFilterSheet({super.key});

  @override
  State<CatalogFilterSheet> createState() => _CatalogFilterSheetState();
}

class _CatalogFilterSheetState extends State<CatalogFilterSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      CatalogScope.catalogFilterWMOf(context, listen: false).readReferences();
    });
  }

  @override
  Widget build(BuildContext context) => CatalogReferencesStateBuilder(
    builder: (context, state, _) => state.map(
      idle: (_) => const ProgressLayout(),
      progress: (_) => const ProgressLayout(),
      success: (_) => const _FilterLayout(),
      error: (_) => ErrorLayout(onTap: _onErrorTap),
    ),
  );

  void _onErrorTap() {
    CatalogScope.catalogFilterWMOf(context, listen: false).readReferences();
  }
}

class _FilterLayout extends StatelessWidget {
  const _FilterLayout();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: ListView(
          children: const [
            _GenresFilter(),
            _TypeFilter(),
            _PublishStatusFilter(),
            _SortingFilter(),
            _ProductionStatusFilter(),
            _SeasonFilter(),
            _YearFilter(),
            _AgeRatingFilter(),
          ],
        ),
      ),
      const _BottomLayout(),
    ],
  );
}

class _FilterBuilder<References, Item> extends StatelessWidget {
  /// Выбирает источник данных для фильтра
  final References Function(AnimeCatalogReferencesModel value) references;

  /// Выбирает значение из модели фильтра
  final Item Function(CatalogFilterEntity value) filter;

  final Widget Function(
    BuildContext context,
    References references,
    Item value,
    ICatalogFilterWM wm,
  )
  builder;

  const _FilterBuilder({
    required this.references,
    required this.filter,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CatalogReferencesStateBuilder(
    builder: (context, state, _) => state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      success: (value) => CatalogFilterStateSelector<Item>(
        selector: (value) => filter(value.filter),
        builder: (context, state, _) {
          final wm = CatalogScope.catalogFilterWMOf(context);
          final values = references(value.references);
          return builder(context, values, state, wm);
        },
      ),
    ),
  );
}

class _GenresFilter extends StatelessWidget {
  const _GenresFilter();

  static const String title = 'Жанры';
  static const String subtitle =
      'Укажите жанры, по которым будут отфильтрованы все наши релизы. '
      'При выборе нескольких — будет использована комбинация';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.genres,
      filter: (value) => value.genres,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.genres,
        selected: filter,
        itemLabel: (value) => value.name,
        itemKey: (value) => value.id,
        onSelected: wm.selectGenre,
      ),
    ),
  );
}

class _TypeFilter extends StatelessWidget {
  const _TypeFilter();

  static const String title = 'Тип';
  static const String subtitle =
      'Укажите типы релизов, по которым '
      'будут отфильтрованы все релизы';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.types,
      filter: (value) => value.types,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.types,
        selected: filter,
        itemLabel: (value) => value.description,
        itemKey: (value) => value.value,
        onSelected: wm.selectType,
      ),
    ),
  );
}

class _PublishStatusFilter extends StatelessWidget {
  const _PublishStatusFilter();

  static const String title = 'Статус выхода';
  static const String subtitle =
      'Укажите желаемые статусы выхода релиза, '
      'по которым будут отфильтрованы все тайтлы в каталоге';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.publishStatuses,
      filter: (value) => value.publishStatuses,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.publishStatuses,
        selected: filter,
        itemLabel: (value) => value.description,
        itemKey: (value) => value.value,
        onSelected: wm.selectPublishStatus,
      ),
    ),
  );
}

class _SortingFilter extends StatelessWidget {
  const _SortingFilter();

  static const String title = 'Сортировка';
  static const String subtitle =
      'Укажите способ сортировки для отображения '
      'всех тайтлов в каталоге';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.sorting,
      filter: (value) => value.sorting,
      builder: (context, references, filter, wm) => FilterRadioItem(
        items: references.sorting,
        selected: filter,
        itemLabel: (value) => value.label,
        itemTooltip: (value) => value.description,
        onSelected: wm.selectSorting,
      ),
    ),
  );
}

class _ProductionStatusFilter extends StatelessWidget {
  const _ProductionStatusFilter();

  static const String title = 'Статус озвучки';
  static const String subtitle =
      'Укажите желаемые статусы озвучки релиза, по которым '
      'будут отфильтрованы все тайтлы в каталоге';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.productionStatuses,
      filter: (value) => value.productionStatuses,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.productionStatuses,
        selected: filter,
        itemLabel: (value) => value.description,
        itemKey: (value) => value.value,
        onSelected: wm.selectProductionStatus,
      ),
    ),
  );
}

class _SeasonFilter extends StatelessWidget {
  const _SeasonFilter();

  static const String title = 'Сезоны';
  static const String subtitle =
      'Укажите желаемые сезоны выхода релизов, '
      'по которым будут отфильтрованы все тайтлы в каталоге';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.seasons,
      filter: (value) => value.seasons,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.seasons,
        selected: filter,
        itemLabel: (value) => value.description,
        itemKey: (value) => value.value,
        onSelected: wm.selectSeasons,
      ),
    ),
  );
}

class _YearFilter extends StatelessWidget {
  const _YearFilter();

  static const String title = 'Период выхода';
  static const String subtitle =
      'Укажите года выхода релиза, по которым '
      'будут отфильтрованы все тайтлы в каталоге';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.years,
      filter: (value) => value.year,
      builder: (context, references, value, wm) => FilterSliderItem(
        max: references.toYear,
        min: references.fromYear,
        minCurrent: value?.fromYear,
        maxCurrent: value?.toYear,
        onChange: wm.selectYear,
      ),
    ),
  );
}

class _AgeRatingFilter extends StatelessWidget {
  const _AgeRatingFilter();

  static const String title = 'Возрастной рейтинг';
  static const String subtitle =
      'Укажите допустимы возрастной рейтинг релизов, '
      'по которым будут отфильтрованы все тайтлы';

  @override
  Widget build(BuildContext context) => CatalogFilterListItem(
    title: title,
    subtitle: subtitle,
    child: _FilterBuilder(
      references: (value) => value.ageRatings,
      filter: (value) => value.ageRatings,
      builder: (context, references, filter, wm) => FilterChipsItem(
        items: references.ageRatings,
        selected: filter,
        itemLabel: (value) => value.label,
        itemKey: (value) => value.value,
        onSelected: wm.selectAgeRating,
      ),
    ),
  );
}

class _BottomLayout extends StatelessWidget {
  const _BottomLayout();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
    child: Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: () => _onApplyTap(context),
            label: const Text('Применить'),
            icon: const Icon(Icons.done_all),
            style: FilledButton.styleFrom(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _onResetTap(context),
            label: const Text('Сбросить'),
            icon: const Icon(Icons.clear),
          ),
        ),
      ],
    ),
  );

  void _onApplyTap(BuildContext context) =>
      CatalogScope.catalogFilterWMOf(context).apply();

  void _onResetTap(BuildContext context) =>
      CatalogScope.catalogFilterWMOf(context).reset();
}
