import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:picolo/picolo.dart';

extension PicoloRenderer on WidgetTester {
  Future<void> pumpPicolo<T>({
    required void Function(dynamic) onSelect,
    List<PickerItem<T>>? items,
  }) async {
    await pumpWidget(
      MaterialApp(
        home: PicoloTriggerer(
          items: items ?? <PickerItem<num>>[],
          onSelect: onSelect,
        ),
      ),
    );
    await pumpAndSettle();
  }
}

class PicoloTriggerer<T> extends StatelessWidget {
  const PicoloTriggerer({
    super.key,
    required this.onSelect,
    required this.items,
  });

  final List<PickerItem<T>> items;
  final void Function(T) onSelect;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Picolo(
        items: items,
        onSelect: onSelect,
      ).show(context: context);
    });
    return const Placeholder();
  }
}

abstract class PicoloFunctions {
  void onSelect(dynamic value);
}

class PicoloFunctionsMock extends Mock implements PicoloFunctions {}
