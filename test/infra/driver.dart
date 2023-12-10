import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:picolo/picolo.dart';

import 'finders.dart';
import 'utils.dart';

class PicoloTestDriver with PicoloTestFinders {
  PicoloTestDriver(this.tester);

  final WidgetTester tester;
  final PicoloFunctionsMock picoloFunctionsMock = PicoloFunctionsMock();
  List<PicoloItem<int>> _items = [];
  PicoloController<int>? _controller;
  Widget? _customPicker;
  BorderRadius? _dialogBorderRadius;
  int? _initialValue;
  EdgeInsets? _itemPadding;
  Color? _itemSelectedColor;
  InputDecoration? _pickerInputDecoration;
  void Function()? _onClosed;
  void Function(int)? _onSelect;

  PicoloController<int>? get controller => _controller;

  PicoloTestDriver withPicker() {
    _items = [
      PicoloItem(label: 'One', value: 1),
      PicoloItem(label: 'Two', value: 2),
    ];
    _onSelect = picoloFunctionsMock.onSelect;
    _onClosed = picoloFunctionsMock.onClosed;
    return this;
  }

  PicoloTestDriver withEmptyPicker() {
    _items = [];
    return this;
  }

  PicoloTestDriver withSingleItemPicker() {
    _items = [
      PicoloItem(label: 'One', value: 1),
    ];
    return this;
  }

  PicoloTestDriver withCustomPicker() {
    _items = [
      PicoloItem(label: 'One', value: 1),
      PicoloItem(label: 'Two', value: 2),
    ];
    _customPicker = const Text("Custom Picker", key: Key('custom-picker'));
    return this;
  }

  PicoloTestDriver withController([int? initialValue]) {
    _controller = PicoloController(initialValue);
    return this;
  }

  PicoloTestDriver withInitialValue(int initialValue) {
    _initialValue = initialValue;
    return this;
  }

  PicoloTestDriver withCustomPickerInputDecoration(String label) {
    _pickerInputDecoration = InputDecoration(label: Text(label));
    return this;
  }

  PicoloTestDriver withCustomDialogBorderRadius(double borderRadius) {
    _dialogBorderRadius = BorderRadius.all(Radius.circular(borderRadius));
    return this;
  }

  PicoloTestDriver withCustomItemPadding(EdgeInsets itemPadding) {
    _itemPadding = itemPadding;
    return this;
  }

  PicoloTestDriver withCustomItemSelectedColor(Color itemSelectedColor) {
    _itemSelectedColor = itemSelectedColor;
    return this;
  }

  Future<PicoloTestDriver> pumpPicolo() async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Picolo<int>(
            controller: _controller,
            customPicker: _customPicker,
            dialogBorderRadius: _dialogBorderRadius,
            initialValue: _initialValue,
            items: _items,
            itemPadding: _itemPadding,
            itemSelectedColor: _itemSelectedColor,
            onClosed: _onClosed,
            onSelect: _onSelect,
            pickerInputDecoration: _pickerInputDecoration,
          ),
        ),
      ),
    );
    return this;
  }
}
