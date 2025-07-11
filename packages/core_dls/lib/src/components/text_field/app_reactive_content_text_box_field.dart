import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/components/text_field/app_reactive_text_field.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class AppReactiveContentTextBoxField extends StatefulWidget {
  const AppReactiveContentTextBoxField({
    super.key,
    required this.formControlName,
    this.focusNode,
    this.maxCharacter = 300,
    this.minLines,
    this.maxLines = 7,
    this.helperText,
    this.hintText,
    this.validationMessages,
    this.enableSuggestions = true,
    this.autoCorrect = true,
  });

  final int? maxCharacter;
  final int? minLines;
  final int? maxLines;
  final FocusNode? focusNode;
  final String formControlName;
  final String? helperText;
  final String? hintText;
  final bool enableSuggestions;
  final bool autoCorrect;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<AppReactiveContentTextBoxField> createState() =>
      _AppContentTextBoxFieldState();
}

class _AppContentTextBoxFieldState
    extends State<AppReactiveContentTextBoxField> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
          ),
          child: AppReactiveTextField(
            formControlName: widget.formControlName,
            validationMessages: widget.validationMessages,
            focusNode: _focusNode,
            hintText: widget.hintText,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            enableSuggestions: widget.enableSuggestions,
            autoCorrect: widget.autoCorrect,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxCharacter),
            ],
          ),
        ),
        if (widget.helperText != null)
          Text(
            widget.helperText!,
            textAlign: TextAlign.right,
            style: context.appTextTheme.bodySmall
                ?.copyWith(color: AppColorTheme.gray400),
          ),
      ],
    );
  }
}
