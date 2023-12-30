library picolo;

import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/controllers/picolo_controller.dart';
import 'package:picolo/src/models/picolo_item.dart';
import 'package:picolo/src/widgets/context.dart';
import 'package:picolo/src/widgets/picker.dart';

export 'package:picolo/src/controllers/picolo_controller.dart';
export 'package:picolo/src/models/picolo_item.dart';

class Picolo<T> extends StatefulWidget {
  const Picolo({
    super.key,
    required this.items,
    this.controller,
    this.customPicker,
    this.initialValue,
    this.itemSelectedColor,
    this.onClosed,
    this.onSelect,
    this.pickerInputDecoration,
    BorderRadius? dialogBorderRadius,
    EdgeInsets? itemPadding,
    bool? removeSelectionOnReselect,
  })  : dialogBorderRadius =
            dialogBorderRadius ?? const BorderRadius.all(Radius.circular(16.0)),
        itemPadding = itemPadding ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        removeSelectionOnReselect = removeSelectionOnReselect ?? false;

  final BorderRadius dialogBorderRadius;
  final T? initialValue;
  final List<PicoloItem<T>> items;
  final EdgeInsets itemPadding;
  final bool removeSelectionOnReselect;
  final PicoloController<T>? controller;
  final Widget? customPicker;
  final Color? itemSelectedColor;
  final void Function()? onClosed;
  final void Function(T?)? onSelect;
  final InputDecoration? pickerInputDecoration;

  @override
  State<Picolo<T>> createState() => _PicoloState<T>();
}

class _PicoloState<T> extends State<Picolo<T>> {
  late final PicoloController<T> controller =
      widget.controller ?? PicoloController<T>(widget.initialValue);

  @override
  Widget build(BuildContext context) {
    return PicoloContext<T>(
      controller: controller,
      customPicker: widget.customPicker,
      dialogBorderRadius: widget.dialogBorderRadius,
      items: widget.items,
      itemPadding: widget.itemPadding,
      itemSelectedColor:
          widget.itemSelectedColor ?? Theme.of(context).primaryColor,
      onClosed: widget.onClosed,
      onSelect: widget.onSelect,
      pickerInputDecoration: widget.pickerInputDecoration,
      removeSelectionOnReselect: widget.removeSelectionOnReselect,
      child: PicoloPicker<T>(key: PicoloKeys.globalKey),
    );
  }
}
