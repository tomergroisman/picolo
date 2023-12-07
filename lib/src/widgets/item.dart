import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/models/picker_item.dart';

class PicoloItem<T> extends StatelessWidget {
  const PicoloItem({
    super.key,
    required this.item,
    required this.borderRadius,
    required this.onSelect,
    required this.isMultiSelect,
    required this.isSelected,
    required this.padding,
    required this.selectedColor,
  });

  final PickerItem<T> item;
  final BorderRadius borderRadius;
  final bool isMultiSelect;
  final bool isSelected;
  final EdgeInsets padding;
  final Function(T) onSelect;
  final Color selectedColor;

  Widget renderMainPart() {
    return Expanded(
      child: Text(
        item.label,
        style: TextStyle(color: isSelected ? selectedColor : null),
      ),
    );
  }

  Widget renderSuffix(BuildContext context) {
    if (isMultiSelect) {
      return Checkbox(
        value: isSelected,
        onChanged: (_) {
          handleSelect(context);
        },
      );
    }

    if (isSelected) {
      return Icon(
        Icons.done,
        color: selectedColor,
      );
    }

    return const SizedBox.shrink();
  }

  void handleSelect(BuildContext context) {
    onSelect(item.value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      key: PicoloItemKeys.container,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          handleSelect(context);
        },
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              renderMainPart(),
              renderSuffix(context),
            ],
          ),
        ),
      ),
    );
  }
}
