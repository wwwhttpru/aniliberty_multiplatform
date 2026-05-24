import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/release/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/release/release_tabs_layout.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/release/widget/widget_model/widget_model.dart';
import 'package:flutter/material.dart';

class ReleaseScreen extends StatefulWidget {
  const ReleaseScreen({super.key});

  @override
  State<ReleaseScreen> createState() => _ReleaseScreenState();
}

class _ReleaseScreenState extends State<ReleaseScreen> {
  late final IReleaseWM _releaseWM;

  @override
  void initState() {
    super.initState();
    _releaseWM = ReleaseScope.releaseWMOf(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _releaseWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: DefaultTabController(
      length: 4,
      child: ReleaseStateBuilder(
        builder: (context, state, _) => AnimateSwitchLayout(
          child: state.map(
            idle: (_) => const ProgressLayout(),
            progress: (_) => const ProgressLayout(),
            success: (value) => _SuccessLayout(value.release),
            error: (_) => ErrorLayout(onTap: _releaseWM.read),
          ),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _SuccessLayout(this.animeRelease);

  @override
  Widget build(BuildContext context) => AnimateSwitchLayout(
    child: context.windowSize.maybeMapWidth(
      orElse: () => _ExpandedLayout(
        animeRelease: animeRelease,
        key: const Key('expanded'),
      ),
      compact: () => _CompactLayout(
        animeRelease: animeRelease,
        key: const Key('compact'),
      ),
    ),
  );
}

class _CompactLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _CompactLayout({required this.animeRelease, super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.spacingAllOrSa;
    final paddingH = context.spacingHOrSa;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding.copyWith(bottom: 16),
          sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
        ),
        SliverPadding(
          padding: paddingH,
          sliver: SliverToBoxAdapter(child: _PosterLayout(animeRelease)),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: paddingH,
          sliver: SliverToBoxAdapter(child: _ReleaseNameLayout(animeRelease)),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverPadding(
          padding: paddingH,
          sliver: SliverToBoxAdapter(
            child: _MainLabelsRow(animeRelease: animeRelease),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverPadding(
          padding: paddingH,
          sliver: SliverToBoxAdapter(
            child: _InfoCardsGrid(animeRelease: animeRelease),
          ),
        ),
        SliverPadding(
          padding: paddingH.copyWith(top: 16, bottom: 8),
          sliver: SliverToBoxAdapter(
            child: _DescriptionLayout(animeRelease.description),
          ),
        ),
        SliverPadding(
          padding: paddingH,
          sliver: const SliverToBoxAdapter(child: ReleaseTabsLayout()),
        ),
        SliverPadding(
          padding: padding.copyWith(top: 16),
          sliver: ReleaseTabsBodyLayout(animeRelease: animeRelease),
        ),
      ],
    );
  }
}

class _ExpandedLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _ExpandedLayout({required this.animeRelease, super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.spacingAllOrSa;
    final paddingH = context.spacingHOrSa;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: padding.copyWith(bottom: 16),
          sliver: const SliverToBoxAdapter(child: BackButtonLayout()),
        ),
        SliverPadding(
          padding: paddingH,
          sliver: SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _PosterLayout(animeRelease),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      _ReleaseNameLayout(animeRelease),
                      _MainLabelsRow(animeRelease: animeRelease),
                      _InfoCardsGrid(animeRelease: animeRelease),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: paddingH.copyWith(top: 16, bottom: 8),
          sliver: SliverToBoxAdapter(
            child: _DescriptionLayout(animeRelease.description),
          ),
        ),
        SliverPadding(
          padding: paddingH,
          sliver: const SliverToBoxAdapter(child: ReleaseTabsLayout()),
        ),
        SliverPadding(
          padding: padding.copyWith(top: 16),
          sliver: ReleaseTabsBodyLayout(animeRelease: animeRelease),
        ),
      ],
    );
  }
}

class _PosterLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _PosterLayout(this.animeRelease);

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: context.resolver.adaptive(compact: 8, expanded: 12, large: 12),
    shape: context.resolver.cardShape,
    child: ClipRRect(
      borderRadius: context.resolver.cardBorderRadius,
      child: SizedBox(
        width: context.resolver.adaptive(
          compact: null,
          expanded: 340,
          large: 380,
        ),
        height: context.resolver.adaptive(
          compact: 400,
          expanded: 460,
          large: 520,
        ),
        child: StorageNetworkImage(
          src: animeRelease.poster.optimized.src,
          thumbnail: animeRelease.poster.optimized.thumbnail,
        ),
      ),
    ),
  );
}

class _ReleaseNameLayout extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _ReleaseNameLayout(this.animeRelease);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          animeRelease.name.main,
          style: textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        Text(
          animeRelease.name.english ?? '<unknown>',
          style: textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MainLabelsRow extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _MainLabelsRow({required this.animeRelease});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      spacing: 8,
      children: [
        // Возрастной рейтинг
        Tooltip(
          message: animeRelease.ageRating.description,
          child: Chip(
            avatar: const Icon(Icons.shield_rounded),
            label: Text(animeRelease.ageRating.label),
            backgroundColor: theme.colorScheme.errorContainer,
            shape: context.resolver.chipShape,
            side: BorderSide.none,
            iconTheme: IconThemeData(
              color: theme.colorScheme.onErrorContainer,
              size: 18,
            ),
            labelStyle: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onErrorContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Chip(
          avatar: const Icon(Icons.calendar_today_rounded),
          label: Text(animeRelease.publishDay.description),
          backgroundColor: theme.colorScheme.onSurface,
          shape: context.resolver.chipShape,
          side: BorderSide.none,
          iconTheme: IconThemeData(color: theme.colorScheme.surface, size: 18),
          labelStyle: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _InfoCardsGrid extends StatelessWidget {
  final AnimeReleaseModel animeRelease;

  const _InfoCardsGrid({required this.animeRelease});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 4,
    children: [
      _InfoRow(label: 'Тип', value: animeRelease.type.description ?? '—'),
      _InfoRow(label: 'Сезон', value: animeRelease.season.description ?? '—'),
      _InfoRow(label: 'Жанры', value: animeRelease.genresLabel),
      _InfoRow(label: 'Год выхода', value: animeRelease.year.toString()),
      _InfoRow(label: 'Длительность', value: animeRelease.averageDurationLabel),
      _InfoRow(label: 'Всего эпизодов', value: animeRelease.episodesTotalLabel),
      _InfoRow(
        label: 'Общее время просмотра',
        value: animeRelease.totalWatchTimeLabel,
      ),
    ],
  );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text.rich(
      TextSpan(
        text: '$label: ',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionLayout extends StatelessWidget {
  final String? description;

  const _DescriptionLayout(this.description);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final value = description;
    if (value == null) {
      return const SizedBox.shrink();
    }

    return Text(
      value,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        height: 1.5,
      ),
      textAlign: TextAlign.justify,
    );
  }
}
