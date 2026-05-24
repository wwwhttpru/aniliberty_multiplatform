import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/feed/feed.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/common/video_content_grid_item.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/consumer/video_content_random_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/scope/video_content_scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget_model/video_content_random_wm.dart';
import 'package:flutter/material.dart';

/// Feed list widget for displaying random video content.
class VideoContentRandomFeedList extends StatefulWidget {
  /// Creates a new instance of [VideoContentRandomFeedList].
  const VideoContentRandomFeedList({super.key});

  @override
  State<VideoContentRandomFeedList> createState() =>
      _VideoContentRandomFeedListState();
}

class _VideoContentRandomFeedListState
    extends State<VideoContentRandomFeedList> {
  late final IVideoContentRandomWM _videoContentRandomWM;

  @override
  void initState() {
    super.initState();
    _videoContentRandomWM = VideoContentScope.videoContentRandomWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _videoContentRandomWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => FeedCategoryItem(
    title: 'Последние видео',
    subtitle: 'Самые интересные видео ролики от любимой команды',
    onTap: _videoContentRandomWM.openAll,
    child: VideoContentRandomStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.mediaVideoContents),
          error: (_) => ErrorLayout(onTap: _videoContentRandomWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final MediaVideoContentsModel mediaVideoContents;

  const _SuccessLayout(this.mediaVideoContents);

  @override
  Widget build(BuildContext context) => _HorizontalListLayout(
    itemBuilder: (context, index) {
      final value = mediaVideoContents.mediaVideoContents[index];
      return VideoContentGridItem(
        key: ValueKey(value.id),
        videoContent: value,
        onTap: () => _onTap(context, value.url),
      );
    },
    itemCount: mediaVideoContents.mediaVideoContents.length,
  );

  void _onTap(BuildContext context, String url) {
    final wm = VideoContentScope.videoContentRandomWMOf(
      context,
      listen: false,
    );

    return wm.openVideoContent(url);
  }
}

class _HorizontalListLayout extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
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
      return SizedBox(width: 300, child: child);
    },
    separatorBuilder: (context, index) => const SizedBox(
      width: FeedCategoryItem.hPadding,
    ),
  );
}
