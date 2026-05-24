import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/domain/domain.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/consumer/consumer.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/scope/scope.dart';
import 'package:aniliberty_multiplatform/src/features/video_player/widget/settings/settings_section_title.dart';
import 'package:flutter/material.dart';

class QualitySelector extends StatelessWidget {
  /// HLS player streaming data with different quality options
  final PlayerHls hls;

  const QualitySelector({
    required this.hls,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SettingsSectionTitle(
    title: 'Качество',
    children: [
      VideoQualityStateSelector(
        selector: (state) => state.qualityOrNull,
        builder: (context, state, _) => Wrap(
          spacing: 6,
          runSpacing: 6,
          children: _qualities()
              .map(
                (quality) => _QualityChip(
                  text: quality.name,
                  isSelected: quality == state,
                  onTap: () => _onQualitySelected(context, quality),
                ),
              )
              .toList(growable: false),
        ),
      ),
    ],
  );

  /// Returns the available qualities for the given HLS
  Iterable<VideoQuality> _qualities() =>
      VideoQuality.values.where((quality) => quality.hasQualityByHls(hls));

  /// Called when a quality is selected
  ///
  /// Use this to handle the selection event
  void _onQualitySelected(BuildContext context, VideoQuality quality) {
    final wm = PlayerEpisodeScope.settingsWMOf(context);
    return wm.selectQuality(quality);
  }
}

class _QualityChip extends StatelessWidget {
  /// Text of the quality
  ///
  /// Use this to display the text of the quality
  final String text;

  /// Whether the quality is selected
  ///
  /// Use this to determine if the quality is selected
  final bool isSelected;

  /// Callback when the quality is tapped
  ///
  /// Use this to handle the tap event
  final VoidCallback onTap;

  const _QualityChip({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ChoiceChip(
      selected: isSelected,
      label: Text(text),
      onSelected: (_) => onTap(),
      selectedColor: colorScheme.primaryContainer,
      checkmarkColor: colorScheme.onPrimaryContainer,
      labelStyle: TextStyle(
        color: switch (isSelected) {
          true => colorScheme.onPrimaryContainer,
          false => colorScheme.onSurface,
        },
        fontWeight: switch (isSelected) {
          true => FontWeight.w600,
          false => FontWeight.normal,
        },
      ),
      shape: context.resolver.chipShape,
      side: BorderSide(
        color: switch (isSelected) {
          true => colorScheme.primary,
          false => colorScheme.outline.withValues(alpha: 0.3),
        },
      ),
    );
  }
}
