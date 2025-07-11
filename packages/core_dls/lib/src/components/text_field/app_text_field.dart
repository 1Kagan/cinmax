import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

/// Custom Text Field to use in Forms
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    required this.onChange,
    this.updateTextField,
    this.onChangeDebounce,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isRequired = false,
    this.errorText,
    this.fieldKey,
    this.inputFormatters,
    this.noSelectedBorder = const Color(0x4700C2E7),
    this.hasError = false,
    this.padding,
    this.enable = true,
    this.validatorUpdate,
    this.focus,
    this.nextFocus,
    this.textCapitalization = TextCapitalization.none,
    this.fillColor,
    this.textAlignVertical = TextAlignVertical.center,
    this.enableInteractiveSelection = true,
    this.minLines,
    this.borderRadius,
    this.alignment,
    this.validator,
    this.textEditingController,
    this.prefixIcon,
    this.suffixIcon,
    this.autofillHints,
    this.readOnly = false,
    this.onTap,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.helperText,
    this.prefixText,
    this.onSuffixIconTap,
    this.labelText,
    this.customizedSuffixIcon = false,
    this.height = 52,
    this.contentPadding,
    this.suffixIconSize = 50,
    this.suffixIconAlignment = MainAxisAlignment.end,
    this.suffixCustomCloseOff = true,
    this.warningColor = AppColorTheme.red,
    this.showForError = false,
    this.disableInputChangeDecoration = false,
  });

  final bool readOnly;
  final bool? customizedSuffixIcon;
  final String? hintText;
  final void Function(String) onChange;
  final void Function(String)? onChangeDebounce;
  final Duration debounceDuration;
  final void Function(TextEditingController)? updateTextField;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isRequired;
  final String? errorText;
  final Key? fieldKey;
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
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<String>? autofillHints;
  final void Function()? onTap;
  final bool autocorrect;
  final bool enableSuggestions;
  final String? helperText;
  final String? prefixText;
  final String? labelText;
  final void Function()? onSuffixIconTap;
  final double height;
  final EdgeInsets? contentPadding;
  final double suffixIconSize;
  final MainAxisAlignment suffixIconAlignment;
  final bool? suffixCustomCloseOff;
  final Color warningColor;
  final bool showForError;
  final bool disableInputChangeDecoration;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscureText = false;
  late TextEditingController textEditingController;
  var _previousText = '';
  late FocusNode focusNode;
  Timer? _debounceTimer;

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
    _debounceTimer?.cancel();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onChangedDebounce(String value) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChangeDebounce?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;

    final hasErrorBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 18.r),
      color: widget.fillColor ??
          (isLight ? inputDecorationTheme.fillColor : const Color(0x1AFFFFFF)),
      border: Border.all(
        color: focusNode.hasFocus ? colorScheme.error : AppColorTheme.negative,
        width: 1,
      ),
    );
    final enableBorder = BoxDecoration(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 18.r),
      color: widget.fillColor ??
          (isLight ? inputDecorationTheme.fillColor : const Color(0x1AFFFFFF)),
      border: Border.all(
        color: focusNode.hasFocus
            ? colorScheme.primary
            : (isLight ? AppColorTheme.gray200 : const Color(0x33FFFFFF)),
        width: 1,
      ),
    );
    final disableBorder = widget.disableInputChangeDecoration
        ? enableBorder
        : BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 18.r),
            color: isLight
                ? colorScheme.onSurface.withOpacity(0.05)
                : const Color(0x1AFFFFFF),
            border: Border.all(
              color: widget.readOnly
                  ? (isLight
                      ? const Color.fromRGBO(227, 230, 234, 1)
                      : const Color(0x33FFFFFF))
                  : focusNode.hasFocus
                      ? colorScheme.primary
                      : (isLight
                          ? AppColorTheme.gray200
                          : const Color(0x33FFFFFF)),
              width: 1,
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                widget.labelText!,
                style: context.appTextTheme.body!.copyWith(
                  color: isLight
                      ? AppColorTheme.gray500
                      : Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        Container(
          // height: widget.height.h, // Sabit yükseklik kaldırıldı
          decoration: (widget.errorText != null && widget.errorText!.isNotEmpty)
              ? hasErrorBorder
              : widget.enable
                  ? enableBorder
                  : disableBorder,
          child: Row(
            mainAxisAlignment: widget.suffixIconAlignment,
            children: [
              if (widget.suffixIcon != null &&
                  widget.suffixIconAlignment == MainAxisAlignment.start)
                GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: widget.suffixIcon,
                  ),
                ),
              Expanded(
                child: TextFormField(
                  autocorrect: widget.autocorrect,
                  enableSuggestions: widget.enableSuggestions,
                  readOnly: widget.readOnly,
                  autofillHints: widget.autofillHints,
                  style: context.appTextTheme.body!.copyWith(
                    color: widget.enable
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withOpacity(0.5),
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
                  onFieldSubmitted: (value) {
                    widget.onSuffixIconTap?.call();
                  },
                  cursorColor: isLight ? AppColorTheme.text : Colors.white,
                  minLines: widget.minLines,
                  maxLines: widget.minLines != null ? 7 : 1,
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: widget.hasError || widget.fillColor != null,
                    hintText: widget.hintText ?? '',
                    hintStyle: context.appTextTheme.body!.copyWith(
                      color: widget.enable
                          ? colorScheme.onSurface.withOpacity(0.5)
                          : colorScheme.onSurface.withOpacity(0.3),
                    ),
                    prefixText: widget.prefixText,
                    prefixStyle: context.appTextTheme.body!.copyWith(
                      color: widget.enable
                          ? colorScheme.onSurface
                          : colorScheme.onSurface.withOpacity(0.5),
                    ),
                    isDense: true,
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
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
                            TextPosition(
                                offset: textEditingController.text.length),
                          );
                      }
                    } else {
                      widget.onChange(value);
                      _previousText = value;
                    }
                    _onChangedDebounce(value);

                    setState(() {});
                  },
                  validator: widget.validator,
                ),
              ),
              if (textEditingController.text.isNotEmpty &&
                  widget.enable &&
                  widget.suffixCustomCloseOff == true)
                IconButton(
                  onPressed: () {
                    textEditingController.clear();
                    widget.onChange('');
                    widget.onChangeDebounce?.call('');
                    widget.onSuffixIconTap?.call();
                    setState(() {});
                  },
                  icon: widget.suffixIcon ??
                      Icon(
                        Icons.close,
                        color: colorScheme.onSurface,
                      ),
                ),
              if (textEditingController.text.isNotEmpty &&
                  widget.enable &&
                  widget.suffixCustomCloseOff == false)
                IconButton(
                  onPressed: () {
                    textEditingController.clear();
                    widget.onChange('');
                    widget.onChangeDebounce?.call('');
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.close,
                    color: colorScheme.onSurface,
                  ),
                ),
              if (widget.suffixIcon != null &&
                  widget.suffixIconAlignment == MainAxisAlignment.end)
                GestureDetector(
                  onTap: widget.onSuffixIconTap,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: widget.suffixIcon,
                  ),
                ),
            ],
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 16.w),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: colorScheme.error,
                fontSize: 12.sp,
              ),
            ),
          )
        else if (widget.helperText?.isNotEmpty ?? false) ...[
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              widget.hasError
                  ? DLSAssets.icons.infoCircle.svg(height: 16, width: 16)
                  : Icon(
                      Icons.info_outline,
                      size: 16,
                      color: widget.showForError ? widget.warningColor : null,
                    ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Text(
                  widget.helperText ?? '',
                  style: context.appTextTheme.footnote?.copyWith(
                    color: widget.showForError
                        ? widget.warningColor
                        : widget.hasError
                            ? colorScheme.error
                            : null,
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
