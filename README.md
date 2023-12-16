# Picolo Flutter Package

Picolo is a versatile and customizable dialog picker for Flutter applications. It provides an easy-to-use widget that allows you to integrate a sleek and efficient picker dialog into your application with minimal effort. Whether you need a simple selection mechanism or a more complex picker, Picolo has you covered.

## Installation
Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  picolo: ^1.0.0
```
Then, run:

```bash
flutter pub get
```

## Usage
Import the Picolo package:

```dart
import 'package:picolo/picolo.dart';
```

Use the Picolo widget in your Flutter app:

```dart
Picolo<T>(
  dialogBorderRadius: BorderRadius.circular(8.0),
  items: [
    PicoloItem(label: 'One', value: 1),
    PicoloItem(label: 'Two', value: 2),
  ],
  itemPadding: EdgeInsets.all(8.0),
  removeSelectionOnReselect: true,
  controller: PicoloController<T>(1),
  customPicker: Text('Click me to open the picker!'),
  itemSelectedColor: Colors.blue,
  onClosed: () {
  // Handle on dialog closed event
  },
  onSelect: (selectedValue) {
  // Handle on item selected event
  },
  pickerInputDecoration: InputDecoration(
    labelText: 'Select an item',
    hintText: 'Tap to select',
  ),
);
```

## Widget Properties
| Property                    | Required? | Type                  | Details                                                                                                    |
|-----------------------------|-----------|-----------------------|------------------------------------------------------------------------------------------------------------|
| `items`                     | Required  | `List<PicoloItem<T>>` | A list of `PicoloItem<T>` objects representing the items in the picker.                                    |
| `controller`                |           | `PicoloController<T>` | A controller for more control over the picker's state.                                                     |
| `customPicker`              |           | `Widget`              | A custom widget to replace the default picker.                                                             |
| `dialogBorderRadius`        |           | `BorderRadius`        | The border radius of the picker dialog.                                                                    |
| `initialValue`              |           | `T`                   | The initial value to display in the picker. Will be ignored if a controller with initial value is provided |
| `itemPadding`               |           | `EdgeInsets`          | Padding applied to each item in the picker.                                                                |
| `itemSelectedColor`         |           | `Color`               | The foreground color of the selected item.                                                                 |
| `removeSelectionOnReselect` |           | `bool`                | A flag to determine whether to remove selection on reselection.                                            |
| `onClosed`                  |           | `void Function()`     | A callback function invoked when the dialog is closed.                                                     |
| `onSelect`                  |           | `void Function(T?)`   | A callback function invoked when an item is selected.                                                      |
| `pickerInputDecoration`     |           | `InputDecoration`     | `InputDecoration` for styling the input field of the picker.                                               |

## PicoloItem
The `PicoloItem<T>` class represents an item in the picker. It has the following properties:

* `label`: The display label for the item.
* `value`: The value associated with the item.
Example usage:

```dart
PicoloItem<int>(
    label: 'One',
    value: 1,
)
```

## PicoloController
The `PicoloController<T>` class provides control over the state of the picker. It can be used to set and retrieve the selected value. Example usage:

```dart
PicoloController<int> controller = PicoloController<int>(1);
```

