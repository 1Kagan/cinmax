import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/components/text_field/util/app_reactive_text_field_decoration.dart';
import 'package:core_dls/src/components/text_field/widgets/error_label_section.dart';
import 'package:core_dls/src/components/text_field/widgets/helper_text.dart';
import 'package:core_dls/core_dls.dart';

/// Reactive Date Text Field to use in Forms
class AppReactiveDateTextField extends StatefulWidget {
  const AppReactiveDateTextField({
    super.key,
    required this.formControlName,
    required this.firstDate,
    required this.lastDate,
    this.dateFormat,
    this.focusNode,
    this.labelText,
    this.helperText,
    this.errorText,
    this.datePickerLocale,
    this.validationMessages,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat? dateFormat;
  final Locale? datePickerLocale;
  final String formControlName;
  final String? helperText;
  final String? labelText;
  final String? errorText;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  static const borderRadius = 8;

  @override
  State<AppReactiveDateTextField> createState() => ReactiveDateTextFieldState();
}

class ReactiveDateTextFieldState extends State<AppReactiveDateTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, child) {
        final formField = formGroup.control(widget.formControlName);
        final hasError = formField.hasErrors;
        final readOnly = formField.disabled;
        final touched = formField.touched;

        return Column(
          children: [
            Container(
              decoration: BoxDecorationX.appReactiveTextFieldBoxDecoration(
                focusNode: _focusNode,
                hasError: hasError,
                readOnly: readOnly,
                touched: touched,
              ),
              child: ReactiveDatePicker<DateTime>(
                formControlName: widget.formControlName,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
                locale: widget.datePickerLocale,
                builder: (context, picker, child) {
                  return ReactiveTextField(
                    validationMessages: widget.validationMessages,
                    onTap: (datetime) {
                      if (_focusNode.canRequestFocus) {
                        _focusNode.unfocus();
                        picker.showPicker();
                        formField.markAsTouched();
                        setState(() {});
                      }
                    },
                    valueAccessor: DateTimeValueAccessor(
                      dateTimeFormat: widget.dateFormat,
                    ),
                    focusNode: _focusNode,
                    formControlName: widget.formControlName,
                    keyboardType: widget.keyboardType,
                    readOnly: true,
                    style: context.appTextTheme.formPlaceholder,
                    cursorColor: AppColorTheme.text,
                    maxLines: 1,
                    cursorWidth: 2.w,
                    cursorHeight: 20.h,
                    decoration: inputDecoration(
                      value: formField.value,
                      readOnly: readOnly,
                      hasError: hasError,
                      onTap: () => formField.updateValue(null),
                      hasFocus: _focusNode.hasFocus,
                    ),
                  );
                },
              ),
            ),
            if (!readOnly && (widget.helperText?.isNotEmpty ?? false)) ...[
              SizedBox(height: 8.h),
              if (!hasError && (widget.helperText?.isNotEmpty ?? false))
                HelperText(widget.helperText!),
              ErrorLabelSection(
                formControlName: widget.formControlName,
                validationMessages: widget.validationMessages,
              ),
            ]
          ],
        );
      },
    );
  }

  Widget? suffixIcon({
    required DateTime? value,
    required bool readOnly,
    required VoidCallback onTap,
  }) =>
      value != null && !readOnly
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: GestureDetector(
                onTap: onTap,
                child: Center(child: DLSAssets.icons.forbidden2.svg(height: 24.r)),
              ),
            )
          : null;

  Color _generateColor(bool readOnly, bool hasError) {
    if (readOnly) {
      return AppColorTheme.gray300;
    } else {
      if (hasError) {
        return AppColorTheme.gray800;
      } else {
        return AppColorTheme.gray500;
      }
    }
  }

  InputDecoration inputDecoration({
    required DateTime? value,
    required bool readOnly,
    required VoidCallback onTap,
    required bool hasError,
    required bool hasFocus,
  }) =>
      InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        filled: true,
        errorStyle: context.appTextTheme.body?.copyWith(fontSize: 0),
        labelStyle: context.appTextTheme.body!.copyWith(
          color: _generateColor(readOnly, hasError),
        ),
        labelText: widget.labelText,
        isDense: true,
        contentPadding: EdgeInsets.only(
          left: 16.w,
          top: 12.r,
          bottom: 12.r,
        ),
        suffixIcon: widget.suffixIcon ??
            suffixIcon(
              onTap: onTap,
              value: value,
              readOnly: readOnly,
            ),
      );
}
