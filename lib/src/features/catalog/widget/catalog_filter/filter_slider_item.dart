import 'package:flutter/material.dart';

class FilterSliderItem extends StatefulWidget {
  final int min;
  final int max;
  final int? minCurrent;
  final int? maxCurrent;
  final void Function(int from, int to) onChange;

  const FilterSliderItem({
    required this.max,
    required this.min,
    required this.minCurrent,
    required this.maxCurrent,
    required this.onChange,
    super.key,
  });

  @override
  State<FilterSliderItem> createState() => _FilterSliderItemState();
}

class _FilterSliderItemState extends State<FilterSliderItem> {
  late final ValueNotifier<RangeValues> _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ValueNotifier(_initialValue());
  }

  @override
  void didUpdateWidget(covariant FilterSliderItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.minCurrent != oldWidget.minCurrent ||
        widget.maxCurrent != oldWidget.maxCurrent) {
      _notifier.value = _initialValue();
    }
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SliderTheme(
    data: SliderTheme.of(
      context,
    ).copyWith(showValueIndicator: ShowValueIndicator.never),
    child: ValueListenableBuilder(
      valueListenable: _notifier,
      builder: (context, value, _) => Row(
        children: [
          _TextYear(value: value.start),
          Expanded(
            child: RangeSlider(
              onChanged: _onChange,
              onChangeEnd: _onChangeEnd,
              divisions: widget.max - widget.min,
              min: widget.min.toDouble(),
              max: widget.max.toDouble(),
              labels: RangeLabels(
                value.start.toInt().toString(),
                value.end.toInt().toString(),
              ),
              values: value,
            ),
          ),
          _TextYear(value: value.end),
        ],
      ),
    ),
  );

  RangeValues _initialValue() {
    final minRange = widget.minCurrent ?? widget.min;
    final maxRange = widget.maxCurrent ?? widget.max;

    return RangeValues(minRange.toDouble(), maxRange.toDouble());
  }

  void _onChange(RangeValues value) => _notifier.value = value;

  void _onChangeEnd(RangeValues value) {
    _notifier.value = value;
    final start = value.start.toInt();
    final end = value.end.toInt();
    return widget.onChange(start, end);
  }
}

class _TextYear extends StatelessWidget {
  final double value;

  const _TextYear({required this.value});

  @override
  Widget build(BuildContext context) => Text(
    value.toInt().toString(),
    textAlign: TextAlign.start,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.grey,
      fontFeatures: <FontFeature>[const FontFeature.tabularFigures()],
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}
