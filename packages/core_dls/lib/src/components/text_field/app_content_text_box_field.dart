import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class AppContentTextBoxField extends StatefulWidget {
  const AppContentTextBoxField({
    super.key,
    required this.onChanged,
    this.maxCharacter = 300,
    this.maxLines = 7,
    this.helperText,
    this.hintText,
    this.textEditingController,
    this.validator,
    this.textInputAction,
  });

  final void Function(String) onChanged;
  final int? maxCharacter;
  final int? maxLines;
  final String? helperText;
  final String? hintText;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  State<AppContentTextBoxField> createState() => _AppContentTextBoxFieldState();
}

class _AppContentTextBoxFieldState extends State<AppContentTextBoxField> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        widget.textEditingController ?? TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
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
            borderRadius: BorderRadius.circular(28.r),
            color: Theme.of(context).cardColor,
          ),
          child: TextFormField(
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            maxLength: widget.maxCharacter,
            controller: textEditingController,
            textAlignVertical: TextAlignVertical.bottom,
            maxLines: widget.maxLines,
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxCharacter ),
            ],
            style: context.appTextTheme.bodySmall
                ?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColorTheme.transparent,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColorTheme.gray600,
                  width: 2,
                ),
              ),
              hintStyle: context.appTextTheme.body
                  ?.copyWith(color: AppColorTheme.gray400, fontSize: 14.sp),
              isDense: true,
              // contentPadding: EdgeInsets.all(16.r),
              alignLabelWithHint: false,
              hintText: widget.hintText,
            ),
            onChanged: widget.onChanged,
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
