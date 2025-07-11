import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

/// Custom Text Field to use in Forms
class AppSearchTextField extends StatefulWidget {
  const AppSearchTextField({
    super.key,
    required this.hintText,
    required this.onChange,
    this.updateTextField,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.fieldKey,
    this.inputFormatters,
    this.hasEditIcon = true,
    this.noSelectedBorder = const Color(0x4700C2E7),
    this.hasError = false,
    this.padding,
    this.enable = true,
    this.validatorUpdate,
    this.focus,
    this.nextFocus,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.textAlignVertical = TextAlignVertical.bottom,
    this.enableInteractiveSelection = true,
    this.minLines,
    this.borderRadius,
    this.alignment,
    this.validator,
    this.textEditingController,
    this.isAssignController = true,
    this.suffixIcon,
    this.autofillHints,
    this.readOnly = false,
    this.onTap,
    this.onCloseTap,
    this.isBirthDate = false,
    this.helperText,
  });

  final bool readOnly;
  final String hintText;
  final void Function(String) onChange;
  final void Function()? onCloseTap;
  final void Function(TextEditingController)? updateTextField;
  final TextInputType keyboardType;
  final bool isPassword;
  final Key? fieldKey;
  final bool hasEditIcon;
  final Color noSelectedBorder;
  final bool hasError;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  final bool enable;
  final bool Function(String)? validatorUpdate;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final TextAlignVertical textAlignVertical;
  final bool enableInteractiveSelection;
  final int? minLines;
  final double? borderRadius;
  final AlignmentGeometry? alignment;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final bool isAssignController;
  final Widget? suffixIcon;
  final List<String>? autofillHints;
  final void Function()? onTap;
  final bool isBirthDate;
  final String? helperText;

  @override
  State<AppSearchTextField> createState() => _AppSearchTextFieldState();
}

class _AppSearchTextFieldState extends State<AppSearchTextField> {
  bool obscureText = false;
  late TextEditingController textEditingController;
  var _previousText = '';
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    focusNode = widget.focus ?? FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasErrorBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      color: AppColorTheme.negative,
      border: Border.all(
        color: focusNode.hasFocus
            ? AppColorTheme.pureBlack
            : AppColorTheme.negative,
        width: 1,
      ),
    );
    final enableBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      border: Border.all(
        color: focusNode.hasFocus
            ? AppColorTheme.pureBlack
            : widget.isBirthDate
                ? widget.noSelectedBorder
                : widget.readOnly
                    ? const Color.fromRGBO(227, 230, 234, 1)
                    : !widget.hasError
                        ? AppColorTheme.gray500
                        : AppColorTheme.negative,
        width: 1,
      ),
    );
    final disableBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      border: Border.all(
        color: widget.readOnly
            ? const Color.fromRGBO(227, 230, 234, 1)
            : focusNode.hasFocus
                ? AppColorTheme.pureBlack
                : !widget.hasError
                    ? AppColorTheme.gray100
                    : AppColorTheme.negative,
        width: 1,
      ),
    );

    return Column(
      children: [
        Container(
          decoration: widget.hasError
              ? hasErrorBorder
              : widget.enable
                  ? enableBorder
                  : disableBorder,
          child: TextFormField(
            readOnly: widget.readOnly,
            autofillHints: widget.autofillHints,
            style: context.appTextTheme.body!.copyWith(
              color:
                  widget.enable ? AppColorTheme.gray500 : AppColorTheme.gray100,
            ),
            key: widget.fieldKey,
            focusNode: focusNode,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enabled: widget.enable,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            controller: textEditingController,
            obscureText: obscureText,
            inputFormatters: widget.inputFormatters,
            textCapitalization: widget.textCapitalization,
            textAlignVertical: widget.textAlignVertical,
            textInputAction: widget.nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: widget.nextFocus != null
                ? (_) => widget.nextFocus!.requestFocus()
                : null,
            cursorHeight: 16,
            cursorColor: AppColorTheme.text,
            minLines: widget.minLines,
            maxLines: widget.minLines != null ? 7 : 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              filled: widget.hasError || widget.fillColor != null,
              errorStyle: context.appTextTheme.body?.copyWith(fontSize: 0),
              labelText: widget.hintText,
              labelStyle: context.appTextTheme.body!.copyWith(
                color: widget.enable
                    ? AppColorTheme.gray500
                    : AppColorTheme.gray100,
              ),
              isDense: true,
              suffixIconConstraints: BoxConstraints(
                maxWidth: 50.w,
                minWidth: 50.w,
                maxHeight: 56.h,
                minHeight: 56.h,
              ),
              contentPadding: EdgeInsets.only(
                left: 16.w,
                top: 10.h,
                bottom: 10.h,
              ),
              suffixIcon: textEditingController.text.isNotEmpty && widget.enable
                  ? IconButton(
                      onPressed: widget.onCloseTap,
                      icon: DLSAssets.icons.searchZoomOut
                          .svg(height: 24.h),
                    )
                  : Container(
                      alignment: widget.alignment ?? Alignment.center,
                      padding: EdgeInsets.only(right: 20.w),
                      child:
                          DLSAssets.icons.searchNormal.svg(height: 24.h),
                    ),
            ),
            onChanged: (value) {
              if (widget.validatorUpdate != null) {
                if (widget.validatorUpdate!(value)) {
                  widget.onChange(value);
                  _previousText = value;
                } else {
                  textEditingController
                    ..text = _previousText
                    ..selection = TextSelection.fromPosition(
                      TextPosition(offset: textEditingController.text.length),
                    );
                }
              } else {
                widget.onChange(value);
                _previousText = value;
              }
              setState(() {});
            },
            validator: widget.validator,
          ),
        ),
        if (widget.helperText?.isNotEmpty ?? false) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              widget.hasError
                  ? DLSAssets.icons.infoCircle.svg(height: 16, width: 16)
                  : const Icon(
                      Icons.info_outline,
                      size: 16,
                    ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Text(
                  widget.helperText ?? '',
                  style: context.appTextTheme.footnote?.copyWith(
                    color: widget.hasError ? AppColorTheme.negative : null,
                  ),
                ),
              ),
            ],
          )
        ]
      ],
    );
  }
}
