import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:picolo/src/constants/keys.dart';

mixin class PicoloTestFinders {
  // Picker finders
  Finder get pickerContainer => find.byKey(PicoloPickerKeys.container);

  Finder get pickerCustomContainer => find.byKey(const Key('custom-picker'));

  Finder get pickerTextField => find.byKey(PicoloPickerKeys.textField);

  TextField get pickerTextFieldWidget => pickerTextField.evaluate().first.widget as TextField;

  Finder pickerTextFieldLabel(String label) => find.descendant(
        matching: find.text(label),
        of: pickerTextField,
      );

  // Dialog finders
  Finder get dialogContainer => find.byKey(PicoloDialogKeys.container);

  BorderRadius get dialogBorderRadius {
    final Container container = dialogContainer.evaluate().first.widget as Container;
    final BoxDecoration decoration = container.decoration as BoxDecoration;
    return decoration.borderRadius as BorderRadius;
  }

  // Item finders
  Finder get pickerItemContainer => find.byKey(PicoloPickerItemKeys.container);

  Finder get pickerItemInk => find.byKey(PicoloPickerItemKeys.ink);

  Finder get pickerItemLabel => find.byKey(PicoloPickerItemKeys.label);

  Finder get pickerItemSelectedIcon => find.byKey(PicoloPickerItemKeys.selectedIcon);

  Finder pickerItemIndexContainer(int index) => pickerItemContainer.at(index);

  Text pickerItemLabelWidget(int index) => pickerItemLabel.evaluate().elementAt(index).widget as Text;

  Finder pickerItemIndexSelectedIcon(int index) => find.descendant(
        of: find.byKey(PicoloPickerItemKeys.container).at(index),
        matching: pickerItemSelectedIcon,
      );

  BorderRadius? pickerItemBorderRadius(int index) {
    final Material container = pickerItemContainer.evaluate().toList()[index].widget as Material;
    return container.borderRadius as BorderRadius?;
  }

  BorderRadius? pickerItemInkBorderRadius(int index) {
    final InkWell container = pickerItemInk.evaluate().toList()[index].widget as InkWell;
    return container.borderRadius;
  }

  Padding get pickerItemPadding {
    return find
        .descendant(
          of: pickerItemContainer,
          matching: find.byType(Padding),
        )
        .evaluate()
        .first
        .widget as Padding;
  }

  Color get pickerItemLabelColor {
    final Text text = pickerItemLabel.evaluate().first.widget as Text;
    return text.style!.color!;
  }

  Color get pickerItemSelectedIconColor {
    final Icon icon = pickerItemSelectedIcon.evaluate().first.widget as Icon;
    return icon.color!;
  }
}
