import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core_dls/src/components/misc/list_tile_divider.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class LinkListTile extends StatelessWidget {
  const LinkListTile({
    super.key,
    this.icon,
    this.iconPackage,
    required this.title,
    this.onTap,
    this.subtitle,
    this.divider = true,
    this.hasChevronRightIcon = true,
  });

  final String? icon;
  final String? iconPackage;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool divider;
  final bool hasChevronRightIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  SvgPicture.asset(
                    icon!,
                    height: 24.h,
                    width: 24.h,
                    colorFilter: const ColorFilter.mode(
                      AppColorTheme.text,
                      BlendMode.srcIn,
                    ),
                    package: iconPackage,
                  ),
                  SizedBox(width: 16.w),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.appTextTheme.bodySmall,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle ?? '',
                          style: context.appTextTheme.xSmallRegular?.copyWith(
                            color: AppColorTheme.gray500,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                if (hasChevronRightIcon)
                  DLSAssets.icons.arrowRight.svg(
                    colorFilter: const ColorFilter.mode(
                      AppColorTheme.text,
                      BlendMode.srcIn,
                    ),
                  ),
              ],
            ),
          ),
          if (divider) const ListTileDivider(),
        ],
      ),
    );
  }
}
