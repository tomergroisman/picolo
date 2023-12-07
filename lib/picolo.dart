library picolo;

import 'package:flutter/material.dart';
import 'package:picolo/src/models/picker_item.dart';
import 'package:picolo/src/widgets/dialog.dart';

export 'package:picolo/src/models/picker_item.dart';

class Picolo<T> {
  const Picolo({
    required this.items,
    required this.onSelect,
    this.dialogBorderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.onClosed,
    this.selectedValue,
  });

  final BorderRadius dialogBorderRadius;
  final List<PickerItem<T>> items;
  final EdgeInsets itemPadding;
  final void Function(T) onSelect;
  final void Function()? onClosed;
  final T? selectedValue;

  show({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) => PicoloDialog(
        borderRadius: dialogBorderRadius,
        items: items,
        itemPadding: itemPadding,
        onSelect: onSelect,
        selectedValue: selectedValue,
      ),
    ).whenComplete(() {
      onClosed?.call();
    });
  }
}
