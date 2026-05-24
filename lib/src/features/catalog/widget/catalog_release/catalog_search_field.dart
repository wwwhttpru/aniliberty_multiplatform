import 'package:aniliberty_multiplatform/src/features/catalog/widget/scope/catalog_scope.dart';
import 'package:aniliberty_multiplatform/src/features/catalog/widget/widget_model/catalog_release_wm.dart';
import 'package:flutter/material.dart';

class CatalogSearchField extends StatefulWidget {
  const CatalogSearchField({super.key});

  @override
  State<CatalogSearchField> createState() => _CatalogSearchFieldState();
}

class _CatalogSearchFieldState extends State<CatalogSearchField> {
  late final ICatalogReleaseWM _catalogReleaseWM;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _catalogReleaseWM = CatalogScope.catalogReleaseWMOf(
      context,
      listen: false,
    );

    _controller = TextEditingController(
      text: _catalogReleaseWM.search,
    )..addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              hintText: 'Поиск по каталогу...',
              suffixIcon: ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, value, child) {
                  if (value.text.isNotEmpty) {
                    return _ClearButton(onPressed: _controller.clear);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const _FilterButton(),
      ],
    ),
  );

  void _onChanged() => _catalogReleaseWM.onSearch(_controller.text);
}

class _FilterButton extends StatelessWidget {
  const _FilterButton();

  @override
  Widget build(BuildContext context) => IconButton.filledTonal(
    style: IconButton.styleFrom(
      fixedSize: const Size.square(48),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    icon: const Icon(Icons.filter_alt, color: Colors.black),
    onPressed: () => CatalogScope.catalogReleaseWMOf(
      context,
      listen: false,
    ).onTapOpenFilter(),
  );
}

class _ClearButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ClearButton({required this.onPressed});

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: const Icon(Icons.clear),
  );
}
