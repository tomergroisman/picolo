import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/models/picker_item.dart';
import 'package:picolo/src/widgets/item.dart';

class PicoloDialog<T> extends StatelessWidget {
  const PicoloDialog({
    super.key,
    required this.borderRadius,
    required this.onSelect,
    required this.items,
    required this.itemPadding,
    this.selectedValue,
  });

  final BorderRadius borderRadius;
  final void Function(T) onSelect;
  final List<PickerItem<T>> items;
  final EdgeInsets itemPadding;
  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        children: [
          Container(
            key: PicoloDialogKeys.container,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.white,
            ),
            child: Column(
              children: items
                  .map(
                    (it) => PicoloItem(
                      borderRadius: borderRadius,
                      item: it,
                      isMultiSelect: false,
                      isSelected: selectedValue == it.value,
                      onSelect: onSelect,
                      padding: itemPadding,
                      selectedColor: Theme.of(context).primaryColor,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
