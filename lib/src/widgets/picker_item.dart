import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/models/picolo_item.dart';
import 'package:picolo/src/widgets/context.dart';

class PicoloPickerItem<T> extends StatelessWidget {
  const PicoloPickerItem({
    super.key,
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isSelected,
  });

  final PicoloItem<T> item;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;

  BorderRadius? getBorderRadius(PicoloContext<T> picoloContext) {
    if (isFirst) {
      return picoloContext.dialogBorderRadius.copyWith(
        bottomLeft: const Radius.circular(0.0),
        bottomRight: const Radius.circular(0.0),
      );
    }
    if (isLast) {
      return picoloContext.dialogBorderRadius.copyWith(
        topRight: const Radius.circular(0.0),
        topLeft: const Radius.circular(0.0),
      );
    }
    return null;
  }

  Widget renderMainPart(PicoloContext<T> picoloContext) {
    return Expanded(
      child: Text(
        item.label,
        key: PicoloPickerItemKeys.label,
        style: TextStyle(
          color: isSelected ? picoloContext.itemSelectedColor : null,
        ),
      ),
    );
  }

  Widget renderSuffix(PicoloContext<T> picoloContext) {
    if (isSelected) {
      return Icon(
        key: PicoloPickerItemKeys.selectedIcon,
        Icons.done,
        color: picoloContext.itemSelectedColor,
      );
    }

    return const SizedBox.shrink();
  }

  void handleSelect({
    required BuildContext context,
    required PicoloContext<T> picoloContext,
  }) {
    final bool shouldRemoveItem = picoloContext.removeSelectionOnReselect &&
        picoloContext.controller.selectedValue == item.value;
    final T? value = shouldRemoveItem ? null : item.value;
    picoloContext.controller.selectedValue = value;
    picoloContext.onSelect?.call(value);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    PicoloContext<T> picoloContext = PicoloContext.get<T>();
    BorderRadius? borderRadius = getBorderRadius(picoloContext);
    return Material(
      key: PicoloPickerItemKeys.container,
      borderRadius: borderRadius,
      child: InkWell(
        key: PicoloPickerItemKeys.ink,
        borderRadius: borderRadius,
        onTap: () {
          handleSelect(
            context: context,
            picoloContext: picoloContext,
          );
        },
        child: Padding(
          padding: picoloContext.itemPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              renderMainPart(picoloContext),
              renderSuffix(picoloContext),
            ],
          ),
        ),
      ),
    );
  }
}
