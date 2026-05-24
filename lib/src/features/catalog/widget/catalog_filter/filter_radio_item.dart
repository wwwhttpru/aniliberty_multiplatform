import 'package:flutter/material.dart';

class FilterRadioItem<Item> extends StatelessWidget {
  /// Список всех элементов
  final Iterable<Item> items;

  /// Выбранный элемент
  final Item? selected;

  /// Лейбл для отображения
  final String Function(Item value) itemLabel;

  /// Лейбл для отображения тултипа
  final String Function(Item value) itemTooltip;

  /// Вызывается при нажатии на элемент
  final void Function(Item? value) onSelected;

  const FilterRadioItem({
    required this.items,
    required this.selected,
    required this.itemLabel,
    required this.itemTooltip,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items
        .map((value) {
          final isSelected = _isSelected(value);
          return Tooltip(
            message: itemTooltip(value),
            child: FilterChip(
              label: Text(itemLabel(value)),
              onSelected: (_) {
                if (isSelected) {
                  return onSelected(null);
                }

                return onSelected(value);
              },
              selected: isSelected,
            ),
          );
        })
        .toList(growable: false),
  );

  bool _isSelected(Item value) => selected == value;
}
