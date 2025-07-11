import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';

extension BoxDecorationX on BoxDecoration {
  static BoxDecoration appReactiveTextFieldBoxDecoration({
    required FocusNode focusNode,
    required bool hasError,
    required bool readOnly,
    required bool touched,
  }) {
    final combinedErrorFlag = hasError && touched;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: readOnly
          ? AppColorTheme.pureWhite
          : (combinedErrorFlag
              ? AppColorTheme.negativeLight
              : AppColorTheme.pureWhite),
      border: Border.all(
        color: readOnly
            ? AppColorTheme.gray100
            : (focusNode.hasFocus
                ? AppColorTheme.gray800
                : (!combinedErrorFlag
                    ? AppColorTheme.gray500
                    : AppColorTheme.negative)),
        width: readOnly ? 1.r : (focusNode.hasFocus ? 2.r : 1.r),
      ),
    );
  }
}
