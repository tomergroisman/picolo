import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/controllers/picolo_controller.dart';
import 'package:picolo/src/widgets/context.dart';
import 'package:picolo/src/widgets/picker_item.dart';

const _kHorizontalPadding = 20.0;

class PicoloDialog<T> extends StatelessWidget {
  const PicoloDialog({super.key});

  @override
  Widget build(BuildContext context) {
    PicoloContext<T> picoloContext = PicoloContext.get<T>();
    PicoloController<T> picoloController = picoloContext.controller;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        _kHorizontalPadding,
        0,
        _kHorizontalPadding,
        MediaQuery.of(context).padding.bottom,
      ),
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
                  .asMap()
                  .map(
                    (index, it) => MapEntry(
                      index,
                      PicoloPickerItem<T>(
                        item: it,
                        isSelected: picoloController.selectedValue == it.value,
                        isFirst: index == 0,
                        isLast: index == picoloContext.items.length - 1,
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
