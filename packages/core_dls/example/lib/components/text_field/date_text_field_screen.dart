import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/core_dls.dart';

class DateTextFieldScreen extends StatefulWidget {
  const DateTextFieldScreen({super.key});

  @override
  State<DateTextFieldScreen> createState() => _DateTextFieldScreenState();
}

class _DateTextFieldScreenState extends State<DateTextFieldScreen> {
  late final FormGroup _fromGroup;

  static const _readOnlyField = '_readOnlyField';
  static const _dateField = '_dateField';
  static const _dateFieldWithSuffixIcon = '_dateFieldWithSuffixIcon';

  @override
  void initState() {
    super.initState();

    _fromGroup = FormGroup({
      _readOnlyField: FormControl<DateTime>(
        value: DateTime.now(),
        disabled: true,
        validators: [
          Validators.required,
        ],
      ),
      _dateField: FormControl<DateTime>(
        validators: [
          Validators.required,
        ],
      ),
      _dateFieldWithSuffixIcon: FormControl<DateTime>(
        value: DateTime.now(),
        validators: [
          Validators.required,
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Date Text Field',
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Read only',
                style: context.appTextTheme.xSmallEmphasis,
              ),
            ),
            AppDatePickerTextField(
              hintText: 'BirthDate',
              firstDate: DateTime(2020),
              lastDate: DateTime(2024),
              dateFormat: DateFormat.yMMMd(),
              onDateChanged: (dateTime) {
                log(dateTime.toString());
              },
            ),
            ReactiveForm(
              formGroup: _fromGroup,
              child: AppReactiveDateTextField(
                formControlName: _readOnlyField,
                labelText: 'Birthdate',
                firstDate: DateTime(1900),
                lastDate: DateTime(2053),
                dateFormat: DateFormat('dd / MM / yyyy'),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Free',
                style: context.appTextTheme.xSmallEmphasis,
              ),
            ),
            ReactiveForm(
              formGroup: _fromGroup,
              child: AppReactiveDateTextField(
                formControlName: _dateField,
                labelText: 'Birthdate',
                firstDate: DateTime(1900),
                lastDate: DateTime(2053),
                dateFormat: DateFormat('dd / MM / yyyy'),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Free with suffix',
                style: context.appTextTheme.xSmallEmphasis,
              ),
            ),
            ReactiveForm(
              formGroup: _fromGroup,
              child: AppReactiveDateTextField(
                formControlName: _dateFieldWithSuffixIcon,
                labelText: 'Birthdate',
                firstDate: DateTime(1900),
                lastDate: DateTime(2053),
                dateFormat: DateFormat('dd / MM / yyyy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
