import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/components/drop_down/drop_down_model.dart';
import 'package:core_dls/src/components/text_field/widgets/error_label_section.dart';
import 'package:core_dls/src/components/text_field/widgets/helper_text.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class AppReactiveDropDownButton<T extends DropDownModelMixin>
    extends StatefulWidget {
  const AppReactiveDropDownButton({
    super.key,
    required this.formControlName,
    required this.items,
    this.helperText,
    this.focusNode,
    this.onChanged,
    required this.hintText,
    this.validationMessages,
  });

  final List<T> items;
  final String hintText;
  final String formControlName;
  final String? helperText;
  final FocusNode? focusNode;
  final void Function(DropDownModelMixin<T> value)? onChanged;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<AppReactiveDropDownButton<T>> createState() =>
      _AppReactiveDropDownButtonState<T>();
}

class _AppReactiveDropDownButtonState<T extends DropDownModelMixin>
    extends State<AppReactiveDropDownButton<T>> {
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
        final helperTextExists = widget.helperText?.isNotEmpty ?? false;

        return Column(
          children: [
            ReactiveDropdownField<T>(
              dropdownColor: AppColorTheme.pureWhite,
              // Todo(hasan) : no need to show underline after flutter upgrade to 3.10.1
              //underline: const SizedBox(),
              isExpanded: true,
              itemHeight: 48,
              borderRadius: BorderRadius.circular(8.r),
              validationMessages: widget.validationMessages,
              onChanged: (control) => widget.onChanged
                  ?.call(control.value as DropDownModelMixin<T>),
              icon: DLSAssets.icons.arrowDown.svg(
                height: 24.h,
                width: 24.w,
                colorFilter: const ColorFilter.mode(
                  AppColorTheme.pureBlack,
                  BlendMode.srcIn,
                ),
              ),
              hint: Text(
                widget.hintText,
                style: context.appTextTheme.body
                    ?.copyWith(color: AppColorTheme.gray500),
              ),
              items: widget.items
                  .map(
                    (e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(
                        e.label,
                        style: context.appTextTheme.body
                            ?.copyWith(color: AppColorTheme.gray500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  )
                  .toList(),
              focusNode: _focusNode,
              style: context.appTextTheme.body,
              formControlName: widget.formControlName,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColorTheme.gray800,
                    width: 1,
                  ),
                ),
                // enabledBorder: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColorTheme.gray500,
                    width: 1,
                  ),
                ),
                errorBorder: InputBorder.none,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColorTheme.gray100,
                    width: 1,
                  ),
                ),
                filled: true,
                errorStyle: context.appTextTheme.body?.copyWith(fontSize: 0),
                hintStyle: context.appTextTheme.body!.copyWith(
                  color: readOnly
                      ? AppColorTheme.gray300
                      : (hasError
                          ? AppColorTheme.gray800
                          : AppColorTheme.gray500),
                ),
                hintText: widget.hintText,
                isDense: true,
                contentPadding: EdgeInsets.all(16.r),
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
}
