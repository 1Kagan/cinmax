import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:core_dls/src/components/text_field/util/app_reactive_text_field_decoration.dart';
import 'package:core_dls/src/components/text_field/widgets/error_label_section.dart';
import 'package:core_dls/src/components/text_field/widgets/helper_text.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/localization/localization.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

/// Custom Text Field to use in Forms
class AppReactivePhoneField extends StatefulWidget {
  const AppReactivePhoneField({
    super.key,
    required this.formControlName,
    this.focusNode,
    this.helperText,
    this.labelText,
    this.validationMessages,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.words,
  });

  final String formControlName;
  final String? helperText, labelText;
  final FocusNode? focusNode;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  State<AppReactivePhoneField> createState() => ReactivePhoneFieldState();
}

class ReactivePhoneFieldState extends State<AppReactivePhoneField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, formGroup, child) {
        final formField = formGroup.control(widget.formControlName);
        final hasError = formField.hasErrors;
        final readOnly = formField.disabled;
        final touched = formField.touched;
        final value = (formField.value as PhoneNumber?);

        final hasValue = value?.nsn.isNotEmpty ?? false;

        return Column(
          children: [
            Container(
              decoration: BoxDecorationX.appReactiveTextFieldBoxDecoration(
                focusNode: _focusNode,
                hasError: hasError,
                readOnly: readOnly,
                touched: touched,
              ),
              child: ReactivePhoneFormField<PhoneNumber>(
                formControlName: widget.formControlName,
                validationMessages: widget.validationMessages,
                key: widget.key,
                focusNode: _focusNode,
                inputFormatters: [
                  if (widget.inputFormatters != null)
                    ...widget.inputFormatters!,
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: AppColorTheme.text,
                maxLines: 1,
                cursorWidth: 2.w,
                cursorHeight: 12.h,
                textAlign: TextAlign.start,
                shouldFormat: true,
                defaultCountry: IsoCode.TR,
                isCountrySelectionEnabled: false,
                countryCodeStyle: context.appTextTheme.body?.copyWith(
                  color: AppColorTheme.gray500,
                ),
                showFlagInInput: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  errorStyle: context.appTextTheme.body?.copyWith(fontSize: 0),
                  labelStyle: context.appTextTheme.body!.copyWith(
                    color: readOnly
                        ? AppColorTheme.gray300
                        : (hasError
                            ? AppColorTheme.gray800
                            : AppColorTheme.gray500),
                  ),
                  labelText: widget.labelText ?? context.localization.phone,
                  isDense: true,
                  suffixIcon: (hasValue && !readOnly
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: GestureDetector(
                            onTap: () {
                              formGroup
                                  .control(widget.formControlName)
                                  .updateValue(PhoneNumber(
                                    isoCode: value!.isoCode,
                                    nsn: ' ',
                                  ));
                            },
                            child: Center(
                                child:
                                    DLSAssets.icons.forbidden2.svg(height: 24.r)),
                          ),
                        )
                      : null),
                  contentPadding: EdgeInsets.only(
                    left: 16.w,
                    top: 10.r,
                    bottom: 10.r,
                  ),
                ),
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
}
