
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/components/text_field/util/app_reactive_text_field_decoration.dart';
import 'package:core_dls/src/components/text_field/widgets/error_label_section.dart';
import 'package:core_dls/src/components/text_field/widgets/helper_text.dart';
import 'package:core_dls/core_dls.dart';

/// Reactive Password Text Field to use in Forms
class AppReactivePasswordTextField extends StatefulWidget {
  const AppReactivePasswordTextField({
    super.key,
    required this.formControlName,
    this.focusNode,
    this.labelText,
    this.helperText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
    this.suffixIcon,
    this.validationMessages,
    this.obscuringCharacter = '•',
    this.obscureText,
  });

  final String formControlName;
  final String? helperText;
  final String? labelText;
  final String? errorText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final String obscuringCharacter;
  final bool? obscureText;

  @override
  State<AppReactivePasswordTextField> createState() =>
      ReactivePasswordTextFieldState();
}

class ReactivePasswordTextFieldState
    extends State<AppReactivePasswordTextField> {
  late bool obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText ?? true;
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
              child: ReactiveTextField(
                formControlName: widget.formControlName,
                validationMessages: widget.validationMessages,
                readOnly: readOnly,
                key: widget.key,
                focusNode: _focusNode,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                obscuringCharacter: widget.obscuringCharacter,
                obscureText: obscureText,
                textCapitalization: widget.textCapitalization,
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: AppColorTheme.text,
                maxLines: 1,
                cursorWidth: 2.w,
                cursorHeight: 20.h,
                decoration: InputDecoration(
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
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() {
                      obscureText = !obscureText;
                    }),
                    child: SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: Center(
                        child: _isObscure(obscureText),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (!readOnly && (widget.helperText?.isNotEmpty ?? false) ||
                (widget.errorText?.isNotEmpty ?? false)) ...[
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

  Color _generateColor(bool readOnly, bool hasError) {
    if (readOnly) {
      return AppColorTheme.gray300;
    }
    if (hasError) {
      return AppColorTheme.gray800;
    }
    return AppColorTheme.gray500;
  }

  Widget _isObscure(bool obscureText) {
    if (obscureText) {
      return DLSAssets.icons.eyeSlash.svg(height: 24.r);
    } else {
      return DLSAssets.icons.eye.svg(height: 24.r);
    }
  }
}
