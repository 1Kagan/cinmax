import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/l10n/l10n.dart';
void comingSoonBottomSheet(
    BuildContext context,
    ) {
  context.showContentBottomSheet(
    title: context.l10n.translate('coming_soon_title'),
    buttonLabel: context.l10n.translate('ok_button'),
    height: .3.sh,
    onCloseButtonTap: (context) => Navigator.of(context).pop(),
    onButtonTap: (context) => Navigator.of(context).pop(),
    content: Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          22.verticalSpacingRadius,
          DLSAssets.icons.presentionChart.svg(
            width: 50.w,
            height: 50.w,
            colorFilter: ColorFilter.mode(
              Theme.of(context).textTheme.bodySmall!.color!,
              BlendMode.srcIn,
            ),
          ),
          12.verticalSpacingRadius,
          Center(
            child: Text(
              context.l10n.translate('coming_soon_text'),
              style: context.appTextTheme.body,
            ),
          ),
        ],
      ),
    ),
    context: context,
  );
}
