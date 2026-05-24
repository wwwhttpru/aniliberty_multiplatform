import 'package:aniliberty_multiplatform/src/core/core.dart';
import 'package:flutter/material.dart';

class ListRadioSetting<T> extends StatelessWidget {
  /// Title of the setting
  final String title;

  /// Icon of the setting
  final IconData icon;

  /// List of items
  final List<T> items;

  /// Function to get the label of the item
  final String Function(T value) itemLabel;

  /// Selected item
  final T selected;

  /// Callback when item is changed
  final void Function(T value) onChanged;

  const ListRadioSetting({
    required this.title,
    required this.icon,
    required this.items,
    required this.itemLabel,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
    context: context,
    removeLeft: true,
    removeRight: true,
    child: Card(
      margin: EdgeInsets.zero,
      shape: context.resolver.cardShape,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(icon),
            iconColor: Theme.of(context).colorScheme.primary,
            title: Text(title),
          ),
          const Divider(height: 1),
          ...items.map(
            (item) => ListTile(
              title: Text(itemLabel(item)),
              trailing: switch (selected == item) {
                true => const Icon(Icons.check),
                false => null,
              },
              iconColor: Theme.of(context).colorScheme.primary,
              onTap: () => onChanged(item),
            ),
          ),
        ],
      ),
    ),
  );
}
