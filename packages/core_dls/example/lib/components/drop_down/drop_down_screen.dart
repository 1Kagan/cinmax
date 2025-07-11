import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/core_dls.dart';

class CustomObject<T> extends Equatable implements DropDownModelMixin<T> {
  final String name;
  final T _value;

  const CustomObject(
    this.name, {
    required T value,
  }) : _value = value;

  @override
  String get label => name;

  @override
  List<Object?> get props => [name, value];

  @override
  T get value => _value;

  @override
  // TODO: implement isEnabled
  bool get isEnabled => throw UnimplementedError();

  @override
  // TODO: implement textStyle
  TextStyle? get textStyle => throw UnimplementedError();
}

class DropDownScreen extends StatefulWidget {
  const DropDownScreen({super.key});

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  late final FormGroup _formGroup;

  static const _selectedValueField = '_selectedValueField';

  @override
  void initState() {
    super.initState();

    _formGroup = FormGroup({
      _selectedValueField: FormControl<CustomObject<int>>(
        value: const CustomObject('Option B', value: 2),
        validators: [
          Validators.required,
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Dropdown',
      body: ListView(
        children: [
          addTitle(
            title: "Dropdown",
            child: const AppDropDownButton(
              items: [
                CustomObject('Option A', value: 1),
                CustomObject('Option B', value: 2),
                CustomObject('Option C', value: 3),
              ],
              hintText: "Select an item",
            ),
          ),
          SizedBox(height: 24.h),
          addTitle(
            title: "Reactive Dropdown",
            child: ReactiveForm(
              formGroup: _formGroup,
              child: const AppReactiveDropDownButton(
                formControlName: _selectedValueField,
                items: [
                  CustomObject('Option A', value: 1),
                  CustomObject('Option B', value: 2),
                  CustomObject('Option C', value: 3),
                ],
                hintText: "Select an item",
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addTitle({
    String? title,
    required Widget child,
    bool darkMode = false,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: context.appTextTheme.h2?.copyWith(
                color:
                    darkMode ? AppColorTheme.pureWhite : AppColorTheme.darkBg,
              ),
            ),
            SizedBox(height: 16.r),
            child,
          ],
        ),
      );
}
