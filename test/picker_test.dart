import 'package:flutter_test/flutter_test.dart';

import 'infra/driver.dart';

void main() {
  PicoloTestDriver drv;

  group('Render Tests', () {
    testWidgets("should render a picker", (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withPicker()
          .pumpPicolo();

      expect(drv.pickerContainer, findsOneWidget);
      expect(drv.pickerTextField, findsOneWidget);
    });

    group("Initial Value", () {
      testWidgets('should render a picker with initial value selected (config)', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withInitialValue(1)
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');
      });

      testWidgets('should render a picker with initial value selected (controller)', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');
      });

      testWidgets('should prefer the controller value if both controller and initial value configured', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withInitialValue(1)
            .withController(2)
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, 'Two');
      });
    });

    group("Customization", () {
      testWidgets("should render a custom picker", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withCustomPicker()
            .pumpPicolo();

        expect(drv.pickerContainer, findsNothing);
        expect(drv.pickerCustomContainer, findsOneWidget);
      });

      testWidgets('should render a picker with a custom picker input decoration', (tester) async {
        const String pickerLabel = 'Custom input decoration';

        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withSingleItemPicker()
            .withCustomPickerInputDecoration(pickerLabel)
            .pumpPicolo();

        expect(drv.pickerTextFieldLabel(pickerLabel), findsOneWidget);
      });
    });
  });

  group("Action Tests", () {
    testWidgets('should open the dialog on picker tap', (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withPicker()
          .pumpPicolo();

      await tester.tap(drv.pickerContainer);
      await tester.pumpAndSettle();

      expect(drv.dialogContainer, findsOneWidget);
    });

    testWidgets("should open the dialog on custom picker tap", (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withCustomPicker()
          .pumpPicolo();

      await tester.tap(drv.pickerCustomContainer);
      await tester.pumpAndSettle();

      expect(drv.dialogContainer, findsOneWidget);
    });
  });
}
