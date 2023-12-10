import 'package:flutter/material.dart' show Color, Colors, EdgeInsets, ModalBarrier;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'infra/driver.dart';

void main() {
  PicoloTestDriver drv;

  group('Render Tests', () {
    testWidgets('should render a unselected picker item', (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withSingleItemPicker()
          .pumpPicolo();

      await tester.tap(drv.pickerContainer);
      await tester.pumpAndSettle();

      expect(drv.pickerItemContainer, findsOneWidget);
      expect(drv.pickerItemLabel, findsOneWidget);
      expect(drv.pickerItemLabelWidget(0).data, 'One');
      expect(drv.pickerItemSelectedIcon, findsNothing);
    });

    testWidgets('should render a selected picker item', (tester) async {
      drv = await PicoloTestDriver(tester) //
          .withSingleItemPicker()
          .withInitialValue(1)
          .pumpPicolo();

      await tester.tap(drv.pickerContainer);
      await tester.pumpAndSettle();

      expect(drv.pickerItemContainer, findsOneWidget);
      expect(drv.pickerItemLabel, findsOneWidget);
      expect(drv.pickerItemLabelWidget(0).data, 'One');
      expect(drv.pickerItemSelectedIcon, findsOneWidget);
    });

    group("Customization", () {
      group("Item Border Radius", () {
        testWidgets('should render a picker item with a default dialog border radius', (tester) async {
          const double defaultBorderRadius = 12.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemBorderRadius.bottomLeft.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.bottomLeft.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.bottomRight.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.bottomRight.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.topLeft.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.topLeft.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.topRight.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius.topRight.y, defaultBorderRadius);
        });

        testWidgets('should render a dialog with a custom dialog border radius', (tester) async {
          const double borderRadius = 50.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withCustomDialogBorderRadius(borderRadius)
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemBorderRadius.bottomLeft.x, borderRadius);
          expect(drv.pickerItemBorderRadius.bottomLeft.y, borderRadius);
          expect(drv.pickerItemBorderRadius.bottomRight.x, borderRadius);
          expect(drv.pickerItemBorderRadius.bottomRight.y, borderRadius);
          expect(drv.pickerItemBorderRadius.topLeft.x, borderRadius);
          expect(drv.pickerItemBorderRadius.topLeft.y, borderRadius);
          expect(drv.pickerItemBorderRadius.topRight.x, borderRadius);
          expect(drv.pickerItemBorderRadius.topRight.y, borderRadius);
        });
      });

      group("Item Padding", () {
        testWidgets('should render an item with a default item padding', (tester) async {
          const double defaultHorizontalItemPadding = 16.0;
          const double defaultVerticalItemPadding = 12.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemPadding.padding.horizontal, defaultHorizontalItemPadding * 2);
          expect(drv.pickerItemPadding.padding.vertical, defaultVerticalItemPadding * 2);
        });

        testWidgets('should render an item with a custom item padding', (tester) async {
          const double leftPadding = 10.0;
          const double topPadding = 20.0;
          const double rightPadding = 30.0;
          const double bottomPadding = 40.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withCustomItemPadding(
                const EdgeInsets.fromLTRB(leftPadding, topPadding, rightPadding, bottomPadding),
              )
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemPadding.padding.horizontal, leftPadding + rightPadding);
          expect(drv.pickerItemPadding.padding.vertical, topPadding + bottomPadding);
        });
      });

      group("Selected Item Color", () {
        testWidgets('should render an item with a default selected item color', (tester) async {
          const Color primaryColor = Color(0xff6750a4);

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withSingleItemPicker()
              .withInitialValue(1)
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemLabelColor, primaryColor);
          expect(drv.pickerItemSelectedIconColor, primaryColor);
        });

        testWidgets('should render a dialog with a custom selected item color', (tester) async {
          const Color customSelectedColor = Colors.pink;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withCustomItemSelectedColor(customSelectedColor)
              .withSingleItemPicker()
              .withInitialValue(1)
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemLabelColor, customSelectedColor);
          expect(drv.pickerItemSelectedIconColor, customSelectedColor);
        });
      });
    });
  });

  group("Action Tests", () {
    group("Value Selection", () {
      testWidgets("should change the picker value on item selection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, '');

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');
      });

      testWidgets("should change the controller's selected value field on item selection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController()
            .pumpPicolo();

        expect(drv.controller!.selectedValue, null);

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.controller!.selectedValue, 1);
      });
    });

    group("Callbacks Invocation", () {
      testWidgets("should call the onSelect callback on item select", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .pumpPicolo();

        verifyNever(drv.picoloFunctionsMock.onSelect(1));

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(1));
        await tester.pumpAndSettle();

        verify(drv.picoloFunctionsMock.onSelect(2)).called(1);
      });
    });
  });
}
