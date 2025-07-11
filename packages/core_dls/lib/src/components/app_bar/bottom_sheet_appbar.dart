import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/localization/localization.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

import '../../constants/assets.gen.dart';
import '../../theme/app_color_theme.dart';

class BottomSheetAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BottomSheetAppBar({
    this.title,
    super.key,
    this.titleKey,
    this.backButtonKey,
    this.onBackTapped,
    this.onDoneTapped,
    this.darkMode = false,
  });

  final Key? titleKey;
  final Key? backButtonKey;
  final String? title;
  final VoidCallback? onBackTapped;
  final VoidCallback? onDoneTapped;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.only(
          top: 12.r,
          left: 24.r,
          right: 24.r,
        ),
        height: preferredSize.height,
        color: darkMode ? AppColorTheme.darkBg : AppColorTheme.pureWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (onBackTapped != null) ...[
                  TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: onBackTapped,
                    icon: DLSAssets.icons.arrowLeft.svg(
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        darkMode
                            ? AppColorTheme.pureWhite
                            : AppColorTheme.darkBg,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: Text(
                      context.localization.back,
                      style: context.appTextTheme.body?.copyWith(
                          color: darkMode
                              ? AppColorTheme.pureWhite
                              : AppColorTheme.darkBg),
                    ),
                  ),
                ],
                if (onDoneTapped != null) ...[
                  const Spacer(),
                  TextButton(
                    onPressed: onDoneTapped,
                    child: Text(
                      context.localization.done,
                      style: context.appTextTheme.bodyEmphasis?.copyWith(
                          color: darkMode
                              ? AppColorTheme.pureWhite
                              : AppColorTheme.darkBg),
                    ),
                  ),
                ]
              ],
            ),
            3.verticalSpace,
            if (title != null) ...[
              9.verticalSpace,
              Expanded(
                child: Text(
                  title!,
                  key: titleKey,
                  style: context.appTextTheme.h1?.copyWith(
                    color: AppColorTheme.orange,
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(title == null ? 65 : 113);
}
