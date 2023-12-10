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
  final TextEditingController textEditingController = TextEditingController();
  late final PicoloController<T> picoloController;

  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      picoloController = PicoloContext.get<T>().controller;
      picoloController.addListener(_rebuild);
    });
    super.initState();
  }

  @override
  dispose() {
    picoloController.removeListener(_rebuild);
    super.dispose();
  }

  _rebuild() {
    setState(() {});
  }

  _show({required PicoloContext<T> picoloContext}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) => PicoloDialog<T>(),
    ).whenComplete(() {
      picoloContext.onClosed?.call();
    });
  }

  void updateTextEditingController(PicoloContext<T> picoloContext) {
    final PicoloController<T> picoloController = picoloContext.controller;
    final hasSelectedValue = picoloController.selectedValue != null;
    if (hasSelectedValue) {
      textEditingController.text = picoloContext.labelByValue[picoloController.selectedValue]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    PicoloContext<T> picoloContext = PicoloContext.get<T>();
    updateTextEditingController(picoloContext);
    handlePickerTap() {
      _show(picoloContext: picoloContext);
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
