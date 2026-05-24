import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/common/video_content_grid_item.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/consumer/video_content_all_state_consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/scope/video_content_scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_content/widget/widget_model/video_content_all_wm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Screen for displaying all video content.
class VideoContentAllScreen extends StatefulWidget {
  /// Creates a new instance of [VideoContentAllScreen].
  const VideoContentAllScreen({super.key});

  @override
  State<VideoContentAllScreen> createState() => _VideoContentAllScreenState();
}

class _VideoContentAllScreenState extends State<VideoContentAllScreen> {
  late final IVideoContentAllWM _videoContentAllWM;

  @override
  void initState() {
    super.initState();
    _videoContentAllWM = VideoContentScope.videoContentAllWMOf(
      context,
      listen: false,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _videoContentAllWM.read();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: VideoContentAllStateBuilder(
      builder: (context, state, _) => AnimateSwitchLayout(
        child: state.maybeMap<Widget>(
          orElse: () => const ProgressLayout(),
          success: (success) => _SuccessLayout(success.mediaVideoContents),
          error: (_) => ErrorLayout(onTap: _videoContentAllWM.read),
        ),
      ),
    ),
  );
}

class _SuccessLayout extends StatelessWidget {
  final MediaVideoContentsModel mediaVideoContents;

  const _SuccessLayout(this.mediaVideoContents);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    scrollCacheExtent: const ScrollCacheExtent.pixels(1000),
    slivers: [
      SliverPadding(
        padding: context.spacingAll.copyWith(bottom: 16),
        sliver: SliverToBoxAdapter(
          child: BackButtonLayout(onPressed: () => _onBack(context)),
        ),
      ),
      SliverPadding(
        padding: context.spacingH.copyWith(bottom: 16),
        sliver: SliverToBoxAdapter(
          child: Text(
            'Новые видео',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SliverPadding(
        padding: context.spacingH,
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 330,
            childAspectRatio: 330 / 300, // 330 - width, 300 - height
            mainAxisExtent: 300,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final content = mediaVideoContents.mediaVideoContents[index];
            return VideoContentGridItem(
              videoContent: content,
              key: ValueKey(content.id),
              onTap: () => _onTap(context, content.url),
            );
          },
          itemCount: mediaVideoContents.mediaVideoContents.length,
        ),
      ),
      SliverPadding(
        padding: context.spacingAll.copyWith(top: 16),
        sliver: const SliverToBoxAdapter(),
      ),
    ],
  );

  void _onBack(BuildContext context) {
    final wm = VideoContentScope.videoContentAllWMOf(
      context,
      listen: false,
    );

    return wm.close();
  }

  void _onTap(BuildContext context, String url) {
    final wm = VideoContentScope.videoContentAllWMOf(
      context,
      listen: false,
    );

    return wm.openVideoContent(url);
  }
}
