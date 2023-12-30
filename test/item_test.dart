import 'package:flutter/material.dart' show Color, Colors, EdgeInsets;
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
          const double defaultBorderRadius = 16.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withThreeItemPicker()
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemBorderRadius(0)?.bottomLeft.x, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomLeft.y, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomRight.x, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomRight.y, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.topLeft.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topLeft.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topRight.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topRight.y, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomLeft.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomLeft.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomRight.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomRight.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.topLeft.x, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topLeft.y, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topRight.x, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topRight.y, defaultBorderRadius);

          expect(drv.pickerItemBorderRadius(1), null);
          expect(drv.pickerItemInkBorderRadius(1), null);

          expect(drv.pickerItemBorderRadius(2)?.bottomLeft.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomLeft.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomRight.x, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomRight.y, defaultBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.topLeft.x, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topLeft.y, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topRight.x, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topRight.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomLeft.x, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomLeft.y, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomRight.x, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomRight.y, defaultBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.topLeft.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topLeft.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topRight.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topRight.y, 0.0);
        });

        testWidgets('should render a dialog with a custom dialog border radius', (tester) async {
          const double customBorderRadius = 50.0;

          drv = await PicoloTestDriver(tester) //
              .withPicker()
              .withThreeItemPicker()
              .withCustomDialogBorderRadius(customBorderRadius)
              .pumpPicolo();

          await tester.tap(drv.pickerContainer);
          await tester.pumpAndSettle();

          expect(drv.pickerItemBorderRadius(0)?.bottomLeft.x, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomLeft.y, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomRight.x, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.bottomRight.y, 0.0);
          expect(drv.pickerItemBorderRadius(0)?.topLeft.x, customBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topLeft.y, customBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topRight.x, customBorderRadius);
          expect(drv.pickerItemBorderRadius(0)?.topRight.y, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomLeft.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomLeft.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomRight.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.bottomRight.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(0)?.topLeft.x, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topLeft.y, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topRight.x, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(0)?.topRight.y, customBorderRadius);

          expect(drv.pickerItemBorderRadius(1), null);
          expect(drv.pickerItemInkBorderRadius(1), null);

          expect(drv.pickerItemBorderRadius(2)?.bottomLeft.x, customBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomLeft.y, customBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomRight.x, customBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.bottomRight.y, customBorderRadius);
          expect(drv.pickerItemBorderRadius(2)?.topLeft.x, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topLeft.y, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topRight.x, 0.0);
          expect(drv.pickerItemBorderRadius(2)?.topRight.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomLeft.x, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomLeft.y, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomRight.x, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.bottomRight.y, customBorderRadius);
          expect(drv.pickerItemInkBorderRadius(2)?.topLeft.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topLeft.y, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topRight.x, 0.0);
          expect(drv.pickerItemInkBorderRadius(2)?.topRight.y, 0.0);
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

      testWidgets("should change the picker value on item selection when a controller provided", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController()
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

      testWidgets("should keep the picker value on item reselection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');
      });

      testWidgets("should keep the controller's selected value field on item reselection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .pumpPicolo();

        expect(drv.controller!.selectedValue, 1);

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.controller!.selectedValue, 1);
      });

      testWidgets("should remove the picker value on item reselection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .withRemoveSelectionOnReselect()
            .pumpPicolo();

        expect(drv.pickerTextFieldWidget.controller!.text, 'One');

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.pickerTextFieldWidget.controller!.text, '');
      });

      testWidgets("should remove the controller's selected value field on item reselection", (tester) async {
        drv = await PicoloTestDriver(tester) //
            .withPicker()
            .withController(1)
            .withRemoveSelectionOnReselect()
            .pumpPicolo();

        expect(drv.controller!.selectedValue, 1);

        await tester.tap(drv.pickerContainer);
        await tester.pumpAndSettle();
        await tester.tap(drv.pickerItemIndexContainer(0));
        await tester.pumpAndSettle();

        expect(drv.controller!.selectedValue, null);
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
