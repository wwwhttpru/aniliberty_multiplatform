import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/episodes/episode_list_tile.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EpisodesDrawer extends StatelessWidget {
  const EpisodesDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: const _ScrollFloatingButton(
      child: Column(
        children: [
          _TopLayout(),
          Expanded(child: _EpisodesLayout()),
        ],
      ),
    ),
    width: _getDrawerWidth(context),
    shape: LinearBorder.none,
  );

  double? _getDrawerWidth(BuildContext context) {
    final resolver = context.resolver;
    final viewSize = resolver.windowSize;
    final padding = context.spacingHOrSa;
    return viewSize.maybeMapWidth(
      orElse: () => 350 + padding.horizontal, // random number from my head
      compact: () => viewSize.width,
    );
  }
}

class _ScrollFloatingButton extends StatefulWidget {
  final Widget child;

  const _ScrollFloatingButton({
    required this.child,
  });

  @override
  State<_ScrollFloatingButton> createState() => _ScrollFloatingButtonState();
}

class _ScrollFloatingButtonState extends State<_ScrollFloatingButton> {
  late final ValueNotifier<bool> _isVisible;
  late final ValueNotifier<bool> _scrollUp;
  ScrollController? _scrollController;
  Size? _windowSize;
  int? _selectedEpisodeIndex;

  @override
  void initState() {
    super.initState();
    _isVisible = ValueNotifier(false);
    _scrollUp = ValueNotifier(false);
    _selectedEpisodeIndex = _getSelectedEpisodeIndex();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = PrimaryScrollController.of(context);
    final size = MediaQuery.sizeOf(context);
    var shouldUpdate = false;

    if (_scrollController != controller) {
      _scrollController?.removeListener(_onScroll);
      _scrollController = controller;
      _scrollController?.addListener(_onScroll);
      shouldUpdate = true;
    }

    if (_windowSize != size) {
      _windowSize = size;
      shouldUpdate = true;
    }

    if (shouldUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _onScroll();
      });
    }
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    _scrollController = null;
    _isVisible.dispose();
    _scrollUp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      widget.child,
      Positioned(
        right: context.spacingHOrSa.right,
        bottom: context.spacingVOrSa.bottom,
        child: RepaintBoundary(
          child: ValueListenableBuilder(
            valueListenable: _isVisible,
            builder: (context, isVisible, child) => AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
            child: ValueListenableBuilder(
              valueListenable: _scrollUp,
              builder: (context, scrollUp, _) => FloatingActionButton(
                onPressed: _scrollToSelectedEpisode,
                child: Icon(
                  key: ValueKey(scrollUp ? 'up' : 'down'),
                  scrollUp ? Icons.arrow_upward : Icons.arrow_downward,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );

  void _onScroll() {
    final controller = _scrollController;
    if (controller == null || !controller.hasClients) {
      _isVisible.value = false;
      return;
    }

    final selectedIndex = _selectedEpisodeIndex;
    if (selectedIndex == null) {
      _isVisible.value = false;
      return;
    }

    final isVisible = _isSelectedEpisodeVisible(controller, selectedIndex);
    _isVisible.value = !isVisible;
    if (isVisible) {
      return;
    }

    // Определяем направление скролла
    final scrollUp = _shouldScrollUp(controller, selectedIndex);
    _scrollUp.value = scrollUp;
  }

  bool _shouldScrollUp(ScrollController controller, int index) {
    const tileHeight = EpisodeListTile.height;
    const dividerHeight = _Separator.height;
    const itemHeight = tileHeight + dividerHeight;

    // Вычисляем позицию начала элемента
    final itemStartOffset = index * itemHeight;

    // Получаем текущую позицию скролла
    final scrollOffset = controller.offset;

    // Если элемент выше видимой области - скроллить вверх
    // Если элемент ниже видимой области - скроллить вниз
    // Используем центр элемента для более точного определения
    final itemCenter = itemStartOffset + (tileHeight / 2);
    return itemCenter < scrollOffset;
  }

  int? _getSelectedEpisodeIndex() {
    final episodeWM = PlayerEpisodeScope.episodesWMOf(
      context,
      listen: false,
    );
    return episodeWM.selectedEpisodeIndex;
  }

  bool _isSelectedEpisodeVisible(ScrollController controller, int index) {
    const tileHeight = EpisodeListTile.height;
    const dividerHeight = _Separator.height;
    const itemHeight = tileHeight + dividerHeight;

    // Вычисляем позицию начала элемента
    final itemStartOffset = index * itemHeight;
    // Позиция конца элемента
    final itemEndOffset = itemStartOffset + tileHeight;

    // Получаем видимую область
    final viewportHeight = controller.position.viewportDimension;
    final scrollOffset = controller.offset;
    final visibleStart = scrollOffset;
    final visibleEnd = scrollOffset + viewportHeight;

    // Проверяем, находится ли элемент хотя бы частично в видимой области
    // Элемент виден, если его начало или конец находится в видимой области
    return (itemStartOffset >= visibleStart && itemStartOffset <= visibleEnd) ||
        (itemEndOffset >= visibleStart && itemEndOffset <= visibleEnd) ||
        (itemStartOffset <= visibleStart && itemEndOffset >= visibleEnd);
  }

  void _scrollToSelectedEpisode() {
    final controller = _scrollController;
    if (controller == null || !controller.hasClients) return;

    final selectedIndex = _selectedEpisodeIndex;
    if (selectedIndex == null) return;

    const tileHeight = EpisodeListTile.height;
    const dividerHeight = _Separator.height;
    const itemHeight = tileHeight + dividerHeight;

    // Вычисляем позицию начала элемента
    final itemStartOffset = selectedIndex * itemHeight;

    // Получаем высоту viewport для центрирования
    final viewportHeight = controller.position.viewportDimension;

    // Вычисляем offset для центрирования элемента
    // Центр элемента должен быть в центре экрана
    final itemCenter = itemStartOffset + (tileHeight / 2);
    final targetOffset = itemCenter - (viewportHeight / 2);

    // Ограничиваем offset допустимыми значениями
    final maxScrollExtent = controller.position.maxScrollExtent;
    final clampedOffset = targetOffset.clamp(0.0, maxScrollExtent);

    controller.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }
}

class _TopLayout extends StatelessWidget {
  const _TopLayout();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SafeArea(
        minimum: context.spacingAll.copyWith(
          bottom: 0,
        ),
        left: false,
        right: false,
        bottom: false,
        child: ListTile(
          contentPadding: context.spacingAll.copyWith(
            top: 0,
            bottom: 0,
          ),
          title: Text(
            'Эпизоды',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Text(
            'Список эпизодов релиза',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          trailing: IconButton.filledTonal(
            style: IconButton.styleFrom(
              shape: context.resolver.buttonShape,
            ),
            icon: const Icon(Icons.close_rounded),
            onPressed: () => Scaffold.of(context).closeDrawer(),
          ),
        ),
      ),
      const Divider(),
    ],
  );
}

class _EpisodesLayout extends StatelessWidget {
  const _EpisodesLayout();

  @override
  Widget build(BuildContext context) => TitleEpisodeStateBuilder(
    buildWhen: (prev, next) {
      final episode = prev.episodeOrNull != next.episodeOrNull;
      final release = prev.releaseOrNull != next.releaseOrNull;
      return episode || release;
    },
    builder: (context, state, _) {
      final release = state.releaseOrNull;
      final episode = state.episodeOrNull;

      if (release == null) {
        return const ProgressLayout();
      }

      return ListView.separated(
        scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
        primary: true,
        itemCount: release.episodes.length,
        padding: context.spacingVOrSa.copyWith(top: 0),
        itemBuilder: (context, index) {
          final value = release.episodes[index];
          final isSelected = value.uuid == episode?.uuid;
          return EpisodeListTile(
            key: ValueKey(value.uuid),
            episode: value,
            isSelected: isSelected,
          );
        },
        separatorBuilder: (context, index) => const _Separator(),
      );
    },
  );
}

class _Separator extends StatelessWidget {
  const _Separator();

  /// Высота разделителя между эпизодами
  static const double height = 16;

  @override
  Widget build(BuildContext context) => SafeArea(
    minimum: context.spacingH,
    bottom: false,
    top: false,
    child: Divider(
      height: height,
      indent: context.spacingH.left,
      endIndent: context.spacingH.right,
    ),
  );
}
