import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/controllers/picolo_controller.dart';
import 'package:picolo/src/models/picolo_item.dart';

class PicoloContext<T> extends InheritedWidget {
  static PicoloContext<T> get<T>() {
    final PicoloContext<T>? result = PicoloKeys //
        .globalKey
        .currentContext
        ?.dependOnInheritedWidgetOfExactType<PicoloContext<T>>();
    assert(result != null, 'No PicoloContext found in context');
    return result!;
  }

  PicoloContext({
    super.key,
    required super.child,
    required this.controller,
    required this.dialogBorderRadius,
    required this.items,
    required this.itemPadding,
    required this.itemSelectedColor,
    required this.removeSelectionOnReselect,
    this.customPicker,
    this.onClosed,
    this.onSelect,
    this.pickerInputDecoration,
  }) : labelByValue = {for (var item in items) item.value: item.label};

  final PicoloController<T> controller;
  final BorderRadius dialogBorderRadius;
  final List<PicoloItem<T>> items;
  final EdgeInsets itemPadding;
  final Color itemSelectedColor;
  final Map<T, String> labelByValue;
  final bool removeSelectionOnReselect;
  final Widget? customPicker;
  final void Function()? onClosed;
  final void Function(T?)? onSelect;
  final InputDecoration? pickerInputDecoration;

  @override
  bool updateShouldNotify(PicoloContext oldWidget) {
    return true;
  }
}
