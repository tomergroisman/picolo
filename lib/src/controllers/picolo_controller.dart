import 'package:flutter/material.dart';

class PicoloController<T> extends ChangeNotifier {
  PicoloController([T? selectedValue]) : _selectedValue = selectedValue;

  T? _selectedValue;

  get selectedValue => _selectedValue;

  set selectedValue(newValue) {
    _selectedValue = newValue;
    notifyListeners();
  }
}
