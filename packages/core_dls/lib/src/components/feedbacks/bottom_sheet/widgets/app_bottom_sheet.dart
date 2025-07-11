import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class AppBottomSheetBody extends StatelessWidget {
  const AppBottomSheetBody({
    super.key,
    required this.title,
    this.subTitle,
    required this.buttonLabel,
    this.textFieldHint,
    this.onTextFieldChange,
    this.textInputFormatters,
    this.onButtonTap,
    this.onSecondButtonTap,
    this.titleColor,
    this.secondaryButtonType = SecondaryButtonType.normal,
    this.secondButtonLabel,
    this.darkMode,
  });

  final String title;
  final dynamic subTitle;
  final String? textFieldHint;
  final void Function(String)? onTextFieldChange;
  final List<TextInputFormatter>? textInputFormatters;
  final String? buttonLabel;
  final String? secondButtonLabel;
  final void Function()? onButtonTap;
  final void Function()? onSecondButtonTap;
  final Color? titleColor;
  final SecondaryButtonType secondaryButtonType;
  final bool? darkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text(
          title,
          style: context.appTextTheme.h2?.copyWith(
            color: titleColor ?? AppColorTheme.text,
          ),
        ),
        if (subTitle != null) ...[
          SizedBox(height: 16.h),
          if (subTitle is String?)
            Text(
              subTitle ?? '',
              style: context.appTextTheme.bodySmall?.copyWith(
                color: AppColorTheme.text,
              ),
            )
          else
            subTitle!,
        ],
        if (textFieldHint != null) ...[
          SizedBox(height: 24.h),
          AppTextField(
            hintText: textFieldHint!,
            onChange: (text) => onTextFieldChange?.call(text),
            inputFormatters: textInputFormatters,
          ),
        ],
        if (buttonLabel != null) ...[
          SizedBox(height: 24.h),
          SecondaryButton(
            text: buttonLabel!,
            onTap: onButtonTap,
            type: secondaryButtonType,
            darkMode: darkMode ?? false,
          ),
        ],
        if (secondButtonLabel != null) ...[
          SizedBox(height: 16.h),
          secondaryButtonType == SecondaryButtonType.underline
              ? Center(
                  child: UnderlinedTextButton(
                    text: secondButtonLabel!,
                    onPressed: onSecondButtonTap,
                  ),
                )
              : PrimaryButton(
                  text: secondButtonLabel!,
                  onTap: onSecondButtonTap,
                  darkMode: darkMode ?? false,
                ),
        ]
      ],
    );
  }
}
