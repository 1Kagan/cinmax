import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:core_dls/src/components/text_field/app_text_field.dart';

class AppDatePickerTextField extends HookWidget {
  const AppDatePickerTextField({
    required this.onDateChanged,
    required this.firstDate,
    required this.lastDate,
    required this.dateFormat,
    required this.hintText,
    super.key,
    this.initialDate,
  });

  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final String hintText;
  final void Function(DateTime?) onDateChanged;

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    useEffect(
      () {
        textEditingController.text =
            initialDate == null ? '' : dateFormat.format(initialDate!);
        return;
      },
      [initialDate],
    );

    return AppTextField(
      hintText: hintText,
      onChange: (_) {},
      focus: AlwaysDisabledFocusNode(),
      textEditingController: textEditingController,
      onSuffixIconTap: () {
        textEditingController.text = '';
        onDateChanged(null);
      },
      onTap: () async {
        final newSelectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
          builder: (context, child) {
            return child ?? const SizedBox.shrink();
          },
        );
        onDateChanged(newSelectedDate);
        textEditingController
          ..text =
              newSelectedDate != null ? dateFormat.format(newSelectedDate) : ''
          ..selection = TextSelection.fromPosition(
            TextPosition(
              offset: textEditingController.text.length,
              affinity: TextAffinity.upstream,
            ),
          );
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
