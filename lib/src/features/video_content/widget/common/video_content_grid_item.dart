import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/datasource_v2/datasource_v2.dart';
import 'package:flutter/material.dart';

/// {@template video_content_grid_item}
/// Grid item widget for displaying video content in Material 3 style.
/// {@endtemplate}
class VideoContentGridItem extends StatelessWidget {
  /// Video content model to display
  final MediaVideoContentModel videoContent;

  /// Callback function to be called when the item is tapped
  final VoidCallback onTap;

  /// {@macro video_content_grid_item}
  const VideoContentGridItem({
    required this.videoContent,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    shape: context.resolver.cardShape,
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      borderRadius: context.resolver.cardBorderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _Poster(videoContent.image)),
          _Description(
            title: videoContent.title,
            views: videoContent.views,
            comments: videoContent.comments,
          ),
        ],
      ),
    ),
  );
}

/// Poster image widget for video content.
class _Poster extends StatelessWidget {
  /// Poster preview model containing image data
  final PosterPreviewModel image;

  const _Poster(this.image);

  @override
  Widget build(BuildContext context) => SizedBox.expand(
    child: StorageNetworkImage(
      src: image.optimized.preview,
      thumbnail: image.optimized.thumbnail,
    ),
  );
}

/// Description section widget for video content.
class _Description extends StatelessWidget {
  /// Video content title
  final String title;

  /// Number of views
  final int? views;

  /// Number of comments
  final int? comments;

  const _Description({
    required this.title,
    required this.views,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        _Title(text: title),
        _ViewsAndCommentsInfo(
          comments: comments?.toString() ?? '-',
          views: views?.toString() ?? '-',
        ),
      ],
    ),
  );
}

/// Title text widget for video content.
class _Title extends StatelessWidget {
  /// Title text to display
  final String text;

  const _Title({required this.text});

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.start,
    style: Theme.of(context).textTheme.titleSmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.w500,
    ),
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
  );
}

/// Widget displaying views and comments information.
class _ViewsAndCommentsInfo extends StatelessWidget {
  /// Number of comments as string
  final String comments;

  /// Number of views as string
  final String views;

  const _ViewsAndCommentsInfo({
    required this.views,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) => Row(
    spacing: 12,
    children: [
      Flexible(
        child: _InfoItem(
          icon: Icons.comment,
          text: comments,
        ),
      ),
      Flexible(
        child: _InfoItem(
          icon: Icons.visibility,
          text: views,
        ),
      ),
    ],
  );
}

/// Individual info item widget with icon and text.
class _InfoItem extends StatelessWidget {
  /// Icon to display
  final IconData icon;

  /// Text to display
  final String text;

  const _InfoItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 4,
    children: [
      Icon(
        icon,
        size: 16,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      Flexible(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
