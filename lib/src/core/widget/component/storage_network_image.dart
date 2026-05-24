import 'package:aniliberty_multiplatform/src/core/config/config.dart';
import 'package:aniliberty_multiplatform/src/core/widget/component/placeholder_image.dart';
import 'package:aniliberty_multiplatform/src/features/app/app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StorageNetworkImage extends StatefulWidget {
  /// Ссылка на картинку
  final String? src;

  /// Ссылка на набросок основной картинки
  final String? thumbnail;

  const StorageNetworkImage({required this.src, this.thumbnail, super.key});

  @override
  State<StorageNetworkImage> createState() => _StorageNetworkImageState();
}

class _StorageNetworkImageState extends State<StorageNetworkImage> {
  late final AppUrlConfig _urlConfig;

  @override
  void initState() {
    super.initState();
    _urlConfig = AppScope.configOf(context, listen: false).urlConfig;
  }

  @override
  Widget build(BuildContext context) {
    final src = widget.src;

    if (src == null) {
      return const _EmptyLayout();
    }

    return CachedNetworkImage(
      imageUrl: _getUrl(src),
      fit: BoxFit.cover,
      fadeOutDuration: const Duration(milliseconds: 250),
      fadeInCurve: Curves.easeInOut,
      fadeOutCurve: Curves.easeInOut,
      placeholderFadeInDuration: const Duration(milliseconds: 250),
      placeholder: (context, _) => const _EmptyLayout(),
      errorWidget: (context, _, __) => const _ErrorLayout(),

      // Fix https://github.com/Baseflow/flutter_cached_network_image/issues/1007
      // TODO(wwwhttpru): Remove this when the issue is fixed
      errorListener: (_) {},
    );
  }

  String _getUrl(String url) {
    final storage = _urlConfig.storage;
    return '$storage$url';
  }

  // String? _getThumbnailUrl() {
  //   if (widget.thumbnail == null) {
  //     return null;
  //   }
  //   final storage = _urlConfig.storage;
  //   return '$storage${widget.thumbnail}';
  // }
}

class _ErrorLayout extends StatelessWidget {
  const _ErrorLayout();

  @override
  Widget build(BuildContext context) => const PlaceholderImage();
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) => const PlaceholderImage();
}
