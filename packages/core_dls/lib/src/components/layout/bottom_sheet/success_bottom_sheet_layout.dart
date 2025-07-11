import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_text/styled_text.dart';
import 'package:core_dls/src/components/layout/bottom_sheet/bottom_sheet_layout.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class SuccessBottomSheetLayout extends StatelessWidget {
  const SuccessBottomSheetLayout({
    required this.successTitle,
    super.key,
    this.bottomNavigationBar,
    this.successSubtitle,
    this.successTitleStyle,
    this.successSubtitleStyle,
    this.backgroundColor,
    this.onBackTapped,
    this.onDoneTapped,
  });

  final Widget? bottomNavigationBar;
  final String successTitle;
  final String? successSubtitle;
  final Color? backgroundColor;
  final TextStyle? successTitleStyle;
  final TextStyle? successSubtitleStyle;
  final VoidCallback? onBackTapped;
  final VoidCallback? onDoneTapped;

  @override
  Widget build(BuildContext context) {
    return BottomSheetLayout(
      backgroundColor: backgroundColor,
      onDoneTapped: onDoneTapped,
      onBackTapped: onBackTapped,
      body: SizedBox(
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DLSAssets.icons.tickCircle.svg(
              width: 80.r,
              colorFilter: const ColorFilter.mode(
                AppColorTheme.positive,
                BlendMode.srcIn,
              ),
            ),
            12.verticalSpace,
            Text(
              successTitle,
              textAlign: TextAlign.center,
              style: successTitleStyle ??
                  context.appTextTheme.h1?.copyWith(
                    color: AppColorTheme.positive,
                  ),
            ),
            if (successSubtitle != null) ...[
              12.verticalSpace,
              StyledText(
                text: successSubtitle!,
                textAlign: TextAlign.center,
                style: successSubtitleStyle ?? context.appTextTheme.body,
                tags: {
                  'bold': StyledTextTag(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                },
              ),
            ]
          ],
        ),
      ),
      bottomNavigationBar:
          SafeArea(child: bottomNavigationBar ?? const SizedBox.shrink()),
    );
  }
}
