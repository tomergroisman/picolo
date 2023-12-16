import 'package:flutter/material.dart';

import 'package:picolo/src/constants/keys.dart';
import 'package:picolo/src/controllers/picolo_controller.dart';
import 'package:picolo/src/widgets/context.dart';
import 'package:picolo/src/widgets/dialog.dart';

class PicoloPicker<T> extends StatefulWidget {
  const PicoloPicker({super.key});

  @override
  State<PicoloPicker<T>> createState() => _PicoloPickerState<T>();
}

class _PicoloPickerState<T> extends State<PicoloPicker<T>> {
  late final TextEditingController textEditingController;
  late final PicoloController<T> picoloController;
  bool loaded = false;

  @override
  dispose() {
    picoloController.removeListener(updatePickerValue);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (loaded) return;
    loaded = true;
    picoloController = PicoloContext.get<T>().controller;
    picoloController.addListener(updatePickerValue);
    textEditingController = TextEditingController(text: pickerValue);
  }

  void updatePickerValue() {
    setState(() {
      textEditingController.text = pickerValue;
    });
  }

  void show({required PicoloContext<T> picoloContext}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) => PicoloDialog<T>(),
    ).whenComplete(() {
      picoloContext.onClosed?.call();
    });
  }

  String get pickerValue {
    final PicoloContext<T> picoloContext = PicoloContext.get<T>();
    final PicoloController<T> picoloController = picoloContext.controller;
    final hasSelectedValue = picoloController.selectedValue != null;
    if (hasSelectedValue) {
      return picoloContext.labelByValue[picoloController.selectedValue]!;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    PicoloContext<T> picoloContext = PicoloContext.get<T>();

    handlePickerTap() {
      show(picoloContext: picoloContext);
    }

    final bool shouldRenderCustomPicker = picoloContext.customPicker != null;
    if (shouldRenderCustomPicker) {
      return GestureDetector(
        onTap: handlePickerTap,
        child: picoloContext.customPicker,
      );
    }

    return Container(
      key: PicoloPickerKeys.container,
      child: TextField(
        key: PicoloPickerKeys.textField,
        controller: textEditingController,
        canRequestFocus: false,
        decoration: picoloContext.pickerInputDecoration,
        onTap: handlePickerTap,
      ),
    );
  }
}
