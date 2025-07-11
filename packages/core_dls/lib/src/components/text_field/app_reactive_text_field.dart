import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/components/text_field/util/app_reactive_text_field_decoration.dart';
import 'package:core_dls/src/components/text_field/widgets/error_label_section.dart';
import 'package:core_dls/src/components/text_field/widgets/helper_text.dart';
import 'package:core_dls/core_dls.dart';

/// Custom Text Field to use in Forms
class AppReactiveTextField<T> extends StatefulWidget {
  const AppReactiveTextField({
    super.key,
    required this.formControlName,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.minLines,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.validationMessages,
    this.enableSuggestions = true,
    this.autoCorrect = true,
  });

  final int? minLines;
  final int? maxLines;
  final String formControlName;
  final String? helperText;
  final String? labelText;
  final String? hintText;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool enableSuggestions;
  final bool autoCorrect;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;

  @override
  State<AppReactiveTextField> createState() => ReactiveTextFieldState<T>();
}

class ReactiveTextFieldState<T> extends State<AppReactiveTextField<T>> {
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
        final value = (formField.value as String?) ?? '';
        final helperTextExists = widget.helperText?.isNotEmpty ?? false;

        return Column(
          children: [
            Container(
              decoration: BoxDecorationX.appReactiveTextFieldBoxDecoration(
                focusNode: _focusNode,
                hasError: hasError,
                readOnly: readOnly,
                touched: touched,
              ),
              child: ReactiveTextField<T>(
                key: widget.key,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                formControlName: widget.formControlName,
                validationMessages: widget.validationMessages,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                textCapitalization: widget.textCapitalization,
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: AppColorTheme.text,
                cursorWidth: 2.w,
                enableSuggestions: widget.enableSuggestions,
                autocorrect: widget.autoCorrect,
                cursorHeight: 12.h,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  hintText: widget.hintText,
                  errorStyle: context.appTextTheme.body?.copyWith(fontSize: 0),
                  labelStyle: context.appTextTheme.body?.copyWith(
                    color: readOnly
                        ? AppColorTheme.gray300
                        : (hasError
                            ? AppColorTheme.gray800
                            : AppColorTheme.gray500),
                  ),
                  labelText: widget.labelText,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    left: 16.w,
                    top: 12.r,
                    bottom: 12.r,
                  ),
                  suffixIcon: _focusNode.hasFocus
                      ? widget.suffixIcon ??
                          deleteSuffixIcon(
                            onTap: () => formField.updateValue(''),
                            value: value,
                            readOnly: readOnly,
                          )
                      : null,
                ),
              ),
            ),
            if (!readOnly) ...[
              SizedBox(height: 8.h),
              if (!hasError && helperTextExists) HelperText(widget.helperText!),
              ErrorLabelSection<T>(
                formControlName: widget.formControlName,
                validationMessages: widget.validationMessages,
              ),
            ]
          ],
        );
      },
    );
  }

  Widget? deleteSuffixIcon({
    required String value,
    required bool readOnly,
    required VoidCallback onTap,
  }) =>
      value.isNotEmpty && !readOnly
          ? SizedBox(
              height: 24.h,
              width: 24.h,
              child: GestureDetector(
                onTap: onTap,
                child: Center(child: DLSAssets.icons.forbidden2.svg(height: 24.r)),
              ),
            )
          : null;
}
