import 'package:flutter/material.dart';

class FilterChipsItem<K, Item> extends StatelessWidget {
  /// Список всех элементов
  final Iterable<Item> items;

  /// Список выбранных элементов
  final Map<K, Item> selected;

  /// Лейбл для отображения
  final String Function(Item value) itemLabel;

  final K Function(Item value) itemKey;

  /// Вызывается при нажатии на элемент
  final void Function(Item value) onSelected;

  const FilterChipsItem({
    required this.items,
    required this.selected,
    required this.itemLabel,
    required this.itemKey,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items
        .map(
          (value) => FilterChip(
            label: Text(itemLabel(value)),
            onSelected: (_) => onSelected(value),
            selected: _isSelected(value),
          ),
        )
        .toList(growable: false),
  );

  bool _isSelected(Item value) {
    final itemK = itemKey(value);
    final selectedItem = selected[itemK];
    return selectedItem != null;
  }
}
