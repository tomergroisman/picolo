import 'package:flutter/material.dart' show ModalBarrier;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'infra/driver.dart';

void main() {
  PicoloTestDriver drv;

  group('Render Tests', () {
    testWidgets('should render a picker dialog', (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withPicker()
          .pumpPicolo();

      await tester.tap(drv.pickerContainer);
      await tester.pumpAndSettle();

      expect(drv.dialogContainer, findsOneWidget);
    });

    group("Number of Items", () {
      testWidgets('should render an empty picker dialog', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withEmptyPicker()
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsNothing);
      });

      testWidgets('should render a single picker item dialog', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withSingleItemPicker()
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsOneWidget);
      });

      testWidgets('should render multiple picker items dialog', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsNWidgets(2));
      });
    });

    group("Initial Value", () {
      testWidgets('should render a picker dialog with initial value selected (config)', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withInitialValue(1)
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsNWidgets(2));
        expect(drv.pickerItemSelectedIcon, findsOneWidget);
        expect(drv.pickerItemIndexSelectedIcon(0), findsOneWidget);
        expect(drv.pickerItemIndexSelectedIcon(1), findsNothing);
      });

      testWidgets('should render a picker dialog with initial value selected (controller)', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsNWidgets(2));
        expect(drv.pickerItemSelectedIcon, findsOneWidget);
        expect(drv.pickerItemIndexSelectedIcon(0), findsOneWidget);
        expect(drv.pickerItemIndexSelectedIcon(1), findsNothing);
      });

      testWidgets('should prefer the controller value if both controller and initial value configured', (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withInitialValue(1)
            .withController(2)
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();

        expect(drv.pickerItemContainer, findsNWidgets(2));
        expect(drv.pickerItemSelectedIcon, findsOneWidget);
        expect(drv.pickerItemIndexSelectedIcon(0), findsNothing);
        expect(drv.pickerItemIndexSelectedIcon(1), findsOneWidget);
      });
    });

    group("Customization", () {
      group("Dialog Border Radius", () {
        testWidgets('should render a dialog with a default dialog border radius', (tester) async {
          const double defaultBorderRadius = 12.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.dialogBorderRadius.bottomLeft.x, defaultBorderRadius);
          expect(drv.dialogBorderRadius.bottomLeft.y, defaultBorderRadius);
          expect(drv.dialogBorderRadius.bottomRight.x, defaultBorderRadius);
          expect(drv.dialogBorderRadius.bottomRight.y, defaultBorderRadius);
          expect(drv.dialogBorderRadius.topLeft.x, defaultBorderRadius);
          expect(drv.dialogBorderRadius.topLeft.y, defaultBorderRadius);
          expect(drv.dialogBorderRadius.topRight.x, defaultBorderRadius);
          expect(drv.dialogBorderRadius.topRight.y, defaultBorderRadius);
        });

        testWidgets('should render a dialog with a custom dialog border radius', (tester) async {
          const double borderRadius = 50.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withCustomDialogBorderRadius(borderRadius)
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.dialogBorderRadius.bottomLeft.x, borderRadius);
          expect(drv.dialogBorderRadius.bottomLeft.y, borderRadius);
          expect(drv.dialogBorderRadius.bottomRight.x, borderRadius);
          expect(drv.dialogBorderRadius.bottomRight.y, borderRadius);
          expect(drv.dialogBorderRadius.topLeft.x, borderRadius);
          expect(drv.dialogBorderRadius.topLeft.y, borderRadius);
          expect(drv.dialogBorderRadius.topRight.x, borderRadius);
          expect(drv.dialogBorderRadius.topRight.y, borderRadius);
        });
      });
    });
  });

  group("Action Tests", () {
    group("Value Selection", () {
      testWidgets("should close the dialog on item selection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController()
            .pumpPicolo();

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        expect(drv.dialogContainer, findsOneWidget);

        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.dialogContainer, findsNothing);
        expect(drv.pickerContainer, findsOneWidget);
      });
    });

    group("Callbacks Invocation", () {
      testWidgets("should call the onClose callback on item select", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .pumpPicolo();

        verifyNever(drv.picoloFunctionsMock.onClosed());

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(1));
        await tester.pumpAndSettle();

        verify(drv.picoloFunctionsMock.onClosed()).called(1);
      });

      testWidgets("should call the onClose callback on dialog dismiss (tap outside)", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .pumpPicolo();

        verifyNever(drv.picoloFunctionsMock.onClosed());

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ModalBarrier).last);
        await tester.pumpAndSettle();

        verify(drv.picoloFunctionsMock.onClosed()).called(1);
      });
    });
  });
}
