import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

import '../../constants/assets.gen.dart';
import '../../theme/app_color_theme.dart';

class SubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  SubPageAppBar({
    super.key,
    this.titleKey,
    this.backButtonKey,
    required this.title,
    this.onBack,
    this.isBackActionEnabled = true,
    this.backIcon,
    double? height,
    this.color,
    this.titleColor = AppColorTheme.pureBlack,
    this.titleStyle,
    this.iconColor = Colors.black,
    this.actions = const [],
    this.removeTitle = false,
    this.titleWidget,
  }) {
    if (height != null) {
      this.height = height;
    } else {
      this.height = removeTitle ? 60 : 96;
    }
  }

  final Key? titleKey;
  final Key? backButtonKey;
  final String title;
  final VoidCallback? onBack;
  late final double height;
  final Color? color;
  final List<Widget> actions;
  final Color titleColor;
  final Color iconColor;
  final TextStyle? titleStyle;
  final bool isBackActionEnabled;
  final SvgPicture? backIcon;
  final bool removeTitle;

  /// Widget in the Subpage Bar which replaces the title text
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.only(
          bottom: 8.h,
          top: 12.h,
          left: 24.r,
          right: 24.r,
        ),
        height: height.h,
        color: color ?? AppColorTheme.pureWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  key: backButtonKey,
                  behavior: HitTestBehavior.translucent,
                  onTap: isBackActionEnabled
                      ? onBack ?? () => Navigator.pop(context)
                      : null,
                  child: SizedBox(
                    height: 40.h,
                    width: 40.h,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: isBackActionEnabled
                          ? backIcon ??
                              DLSAssets.icons.arrowLeft.svg(
                                  height: 24.h,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).iconTheme.color!,
                                    BlendMode.srcIn,
                                  ))
                          : const Text(''),
                    ),
                  ),
                ),
                const Spacer(),
                ...actions,
              ],
            ),
            if (!removeTitle) 5.verticalSpace,
            if (title.isNotEmpty && !removeTitle && titleWidget == null)
              Expanded(
                child: FittedBox(
                  child: Text(
                    title,
                    key: titleKey,
                    style: titleStyle ??
                        context.appTextTheme.h3?.copyWith(
                          color: titleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        ),
                  ),
                ),
              )
            else if (titleWidget != null && !removeTitle)
              Expanded(
                child: titleWidget!,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}
