import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

/// Custom Text Field to use in Navigation Forms
class NavigationSearchTextField extends StatefulWidget {
  const NavigationSearchTextField({
    required this.hintText,
    required this.onChange,
    required this.onClear,
    required this.onGoToSetting,
    super.key,
    this.updateTextField,
    this.keyboardType = TextInputType.text,
    this.fieldKey,
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
    this.preFixIcon,
    this.autofillHints,
    this.readOnly = false,
    this.onTap,
    this.helperText,
    this.autoFocus,
    this.gotoSettingIcon,
  });

  final bool readOnly;
  final String hintText;
  final void Function(String) onChange;
  final void Function() onClear;
  final void Function() onGoToSetting;

  final void Function(TextEditingController)? updateTextField;
  final TextInputType keyboardType;
  final Key? fieldKey;
  final bool hasEditIcon;
  final Color noSelectedBorder;
  final bool hasError;
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
  final Widget? preFixIcon;
  final List<String>? autofillHints;
  final void Function()? onTap;
  final String? helperText;

  final Widget? gotoSettingIcon;
  final bool? autoFocus;

  @override
  State<NavigationSearchTextField> createState() =>
      _NavigationSearchTextField();
}

class _NavigationSearchTextField extends State<NavigationSearchTextField> {
  late TextEditingController textEditingController;
  var _previousText = '';
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    focusNode = widget.focus ?? FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
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
            ? Theme.of(context).colorScheme.onSecondary
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
                ? Theme.of(context).primaryColor
                : !widget.hasError
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor,
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
            autofocus: widget.autoFocus ?? false,
            readOnly: widget.readOnly,
            autofillHints: widget.autofillHints,
            // style: context.appTextTheme.body!.copyWith(
            //   color:
            //       widget.enable ? AppColorTheme.gray500 : AppColorTheme.gray100,
            // ),
            key: widget.fieldKey,
            focusNode: focusNode,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            enabled: widget.enable,
            onTap: widget.onTap,
            keyboardType: widget.keyboardType,
            controller: textEditingController,
            textCapitalization: widget.textCapitalization,
            textAlignVertical: widget.textAlignVertical,
            textInputAction: widget.nextFocus != null
                ? TextInputAction.next
                : TextInputAction.done,
            onFieldSubmitted: widget.nextFocus != null
                ? (_) => widget.nextFocus!.requestFocus()
                : null,
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
                maxWidth: 100.w,
                minWidth: 100.w,
                maxHeight: 50.h,
                minHeight: 50.h,
              ),
              contentPadding: EdgeInsets.only(
                left: 16.w,
                bottom: 5.h,
              ),
              suffixIcon: textEditingController.text.isNotEmpty && widget.enable
                  ? Row(
                      children: [
                        IconButton(
                          icon: IconButton(
                            padding: const EdgeInsets.fromLTRB(5, 0, 8, 5),
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.close,
                              size: 25,
                              color: AppColorTheme.text,
                            ),
                            onPressed: () {
                              if (widget.autoFocus ?? true) {
                                widget.onClear();
                                textEditingController.clear();
                                setState(() {});
                              } else {
                                textEditingController.clear();
                                setState(() {});
                              }
                            },
                          ),
                          onPressed: () {
                            if (widget.autoFocus ?? true) {
                              widget.onClear();
                              textEditingController.clear();
                              setState(() {});
                            } else {
                              textEditingController.clear();
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(
                          height: 32,
                          child: VerticalDivider(
                            width: 2,
                          ),
                        ),
                        Center(child: widget.suffixIcon),
                      ],
                    )
                  : Row(
                      children: [
                        IconButton(
                          icon: Center(child: widget.preFixIcon),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 32,
                          child: VerticalDivider(
                            width: 2,
                            color: AppColorTheme.text,
                          ),
                        ),
                        Center(child: widget.suffixIcon),
                      ],
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
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              if (widget.hasError)
                DLSAssets.icons.infoCircle.svg(height: 16, width: 16)
              else
                const Icon(
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
          ),
        ],
      ],
    );
  }
}
