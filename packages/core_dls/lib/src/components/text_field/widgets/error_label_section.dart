import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class ErrorLabelSection<T> extends StatelessWidget {
  const ErrorLabelSection({
    super.key,
    this.validationMessages,
    required this.formControlName,
  });

  final String formControlName;

  final Map<String, ValidationMessageFunction>? validationMessages;

  Map<String, Object> _matchedErrors(Map<String, Object> errors) {
    var messages = {...validationMessages ?? {}};
    var filteredErrors = messages
      ..removeWhere(
        (key, value) => !errors.containsKey(key),
      );
    return filteredErrors;
  }

  List<String> activeErrors(Map<String, Object> errors) {
    return _matchedErrors(errors).entries.map((entry) {
      final key = entry.key;
      final errorObject = errors[key]!;
      return (entry.value as ValidationMessageFunction).call(errorObject);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final formField = form.control(formControlName);
        final errors = activeErrors(formField.errors);
        if (!formField.touched) return const SizedBox.shrink();
        return Column(
          children: errors
              .map(
                (e) => _errorLabel(context, error: e),
              )
              .toList(),
        );
      },
    );
  }

  Widget _errorLabel(
    BuildContext context, {
    required String error,
  }) =>
      Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: Row(
          children: [
            DLSAssets.icons.infoCircle.svg(
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                AppColorTheme.negative,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                error,
                style: context.appTextTheme.footnote?.copyWith(
                  color: AppColorTheme.negative,
                ),
              ),
            ),
          ],
        ),
      );
}
