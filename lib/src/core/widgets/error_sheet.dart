import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/l10n/l10n.dart';

void showErrorBottomSheet({
  required BuildContext context,
  required String buttonLabelTitle,
  required String informationTitle,
}) {
  context.showContentBottomSheet(
    title: context.l10n.translate(' '),
    buttonLabel: buttonLabelTitle,
    onCloseButtonTap: (context) => Navigator.of(context).pop(),
    onButtonTap: (_) {
      Navigator.of(context).pop();
    },
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: DLSAssets.icons.closeCircle.svg(
            width: 50.w,
            height: 50.w,
            colorFilter: const ColorFilter.mode(
              AppColorTheme.red,
              BlendMode.srcIn,
            ),
          ),
        ),
        12.verticalSpacingRadius,
        Text(
          informationTitle,
          style: context.appTextTheme.body,
          textAlign: TextAlign.center,
        ),
        12.verticalSpacingRadius,
      ],
    ),
    context: context,
  );
}
