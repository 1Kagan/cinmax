import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_text/styled_text.dart';
import 'package:core_dls/src/components/layout/bottom_sheet/bottom_sheet_layout.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class ErrorBottomSheetLayout extends StatelessWidget {
  const ErrorBottomSheetLayout({
    required this.errorTitle,
    super.key,
    this.bottomNavigationBar,
    this.errorSubtitle,
    this.errorTitleStyle,
    this.errorSubtitleStyle,
    this.backgroundColor,
    this.onBackTapped,
    this.onDoneTapped,
  });

  final Widget? bottomNavigationBar;
  final String errorTitle;
  final String? errorSubtitle;
  final Color? backgroundColor;
  final TextStyle? errorTitleStyle;
  final TextStyle? errorSubtitleStyle;
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
            DLSAssets.icons.closeCircle.svg(
              width: 80.r,
              colorFilter: const ColorFilter.mode(
                AppColorTheme.negative,
                BlendMode.srcIn,
              ),
            ),
            12.verticalSpace,
            Text(
              errorTitle,
              textAlign: TextAlign.center,
              style: errorTitleStyle ??
                  context.appTextTheme.h1?.copyWith(
                    color: AppColorTheme.negative,
                  ),
            ),
            if (errorSubtitle != null) ...[
              12.verticalSpace,
              StyledText(
                text: errorSubtitle!,
                textAlign: TextAlign.center,
                style: errorSubtitleStyle ?? context.appTextTheme.body,
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
