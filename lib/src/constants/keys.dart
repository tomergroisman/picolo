import 'package:flutter/material.dart';

class PicoloKeys {
  static GlobalKey globalKey = GlobalKey();
}

class PicoloPickerKeys {
  static const Key container = Key('picolo.picker.container');
  static const Key textField = Key('picolo.picker.text-field');
}

class PicoloDialogKeys {
  static const Key container = Key('picolo.dialog.container');
}

class PicoloPickerItemKeys {
  static const Key container = Key('picolo.picker-item.container');
  static const Key ink = Key('picolo.picker-item.ink');
  static const Key label = Key('picolo.picker-item.label');
  static const Key selectedIcon = Key('picolo.picker-item.selected-icon');
}
