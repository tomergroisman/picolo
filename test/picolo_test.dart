import 'package:flutter_test/flutter_test.dart';
import 'package:picolo/picolo.dart';
import 'package:picolo/src/constants/keys.dart';

import 'utils.dart';

void main() {
  late PicoloFunctionsMock picoloFunctionsMock;

  setUp(() {
    picoloFunctionsMock = PicoloFunctionsMock();
  });

  group('Render Tests', () {
    testWidgets('should render a picker dialog', (tester) async {
      await tester.pumpPicolo(
        onSelect: picoloFunctionsMock.onSelect,
      );

      final containerFinder = find.byKey(PicoloDialogKeys.container);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('should render an empty picker dialog', (tester) async {
      await tester.pumpPicolo(
        items: <PickerItem<String>>[],
        onSelect: picoloFunctionsMock.onSelect,
      );

      final containerFinder = find.byKey(PicoloDialogKeys.container);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('should render a single picker item dialog', (tester) async {
      await tester.pumpPicolo(
        items: [PickerItem(label: 'One', value: 1)],
        onSelect: picoloFunctionsMock.onSelect,
      );

      final containerFinder = find.byKey(PicoloDialogKeys.container);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('should render multiple picker items dialog', (tester) async {
      await tester.pumpPicolo(
        items: [
          PickerItem(label: 'One', value: 1),
          PickerItem(label: 'Two', value: 2),
        ],
        onSelect: picoloFunctionsMock.onSelect,
      );

      final containerFinder = find.byKey(PicoloDialogKeys.container);
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('should render a picker with initial value selected',
        (tester) async {
      await tester.pumpPicolo(
        items: [
          PickerItem(label: 'One', value: 1),
          PickerItem(label: 'Two', value: 2),
        ],
        onSelect: picoloFunctionsMock.onSelect,
      );

      final containerFinder = find.byKey(PicoloDialogKeys.container);
      expect(containerFinder, findsOneWidget);
    });
  });
}
