import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/widgets/context.dart';
import 'package:picolo/src/widgets/picker_item.dart';

class PicoloDialog<T> extends StatelessWidget {
  const PicoloDialog({super.key});

  @override
  Widget build(BuildContext context) {
    PicoloContext<T> picoloContext = PicoloContext.get<T>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Wrap(
        children: [
          Container(
            key: PicoloDialogKeys.container,
            decoration: BoxDecoration(
              borderRadius: picoloContext.dialogBorderRadius,
              color: Colors.white,
            ),
            child: Column(
              children: picoloContext.items
                  .map(
                    (it) => PicoloPickerItem<T>(
                      item: it,
                      isSelected: picoloContext.controller.selectedValue == it.value,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
