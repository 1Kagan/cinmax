import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core_dls/core_dls.dart';

class SmallButton extends StatelessWidget {
  const SmallButton(
    this.label, {
    super.key,
    this.icon,
    this.onTap,
    this.darkMode = false,
  });

  final String? label;
  final VoidCallback? onTap;
  final bool darkMode;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: onTap == null
              ? AppColorTheme.passive
              : (darkMode ? AppColorTheme.darkBg : AppColorTheme.passive),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                height: 16.h,
                width: 16.w,
                colorFilter: ColorFilter.mode(
                  onTap == null
                      ? AppColorTheme.darkBg
                      : (darkMode
                          ? AppColorTheme.passive
                          : AppColorTheme.darkBg),
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              label ?? '',
              textAlign: TextAlign.center,
              style: context.appTextTheme.button?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: onTap == null
                    ? const Color(0xff9E9BAE)
                    : (darkMode
                        ? AppColorTheme.newGrey
                        : AppColorTheme.darkBg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
