library picolo;

import 'package:flutter/material.dart';
import 'package:picolo/src/constants/keys.dart';

import 'package:picolo/src/controllers/picolo_controller.dart';
import 'package:picolo/src/models/picolo_item.dart';
import 'package:picolo/src/widgets/context.dart';
import 'package:picolo/src/widgets/picker.dart';

export 'package:picolo/src/controllers/picolo_controller.dart';
export 'package:picolo/src/models/picolo_item.dart';

class Picolo<T> extends StatelessWidget {
  Picolo({
    super.key,
    required this.items,
    this.customPicker,
    this.itemSelectedColor,
    this.onClosed,
    this.onSelect,
    this.pickerInputDecoration,
    PicoloController<T>? controller,
    BorderRadius? dialogBorderRadius,
    EdgeInsets? itemPadding,
    T? initialValue,
  })  : controller = controller ?? PicoloController<T>(initialValue),
        dialogBorderRadius = dialogBorderRadius ?? const BorderRadius.all(Radius.circular(12.0)),
        itemPadding = itemPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

  final PicoloController<T> controller;
  final BorderRadius dialogBorderRadius;
  final List<PicoloItem<T>> items;
  final EdgeInsets itemPadding;
  final Widget? customPicker;
  final Color? itemSelectedColor;
  final void Function()? onClosed;
  final void Function(T)? onSelect;
  final InputDecoration? pickerInputDecoration;

  @override
  Widget build(BuildContext context) {
    return PicoloContext<T>(
      controller: controller,
      customPicker: customPicker,
      dialogBorderRadius: dialogBorderRadius,
      items: items,
      itemPadding: itemPadding,
      itemSelectedColor: itemSelectedColor ?? Theme.of(context).primaryColor,
      onClosed: onClosed,
      onSelect: onSelect,
      pickerInputDecoration: pickerInputDecoration,
      child: PicoloPicker<T>(key: PicoloKeys.globalKey),
    );
  }
}
