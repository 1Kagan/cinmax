import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class ToastBody extends StatelessWidget {
  const ToastBody({
    super.key,
    required this.title,
    required this.backGroundColor,
    required this.headerIcon,
    required this.borderColor,
  });

  final String title;
  final Color? backGroundColor;
  final Widget? headerIcon;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 24.h,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1.r,
              blurRadius: 7.r,
              offset: const Offset(4, 2),
            ),
          ],
          color: backGroundColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor),
        ),
        width: MediaQuery.of(context).size.width * 0.87,
        child: Row(
          children: [
            headerIcon!,
            SizedBox(width: 12.w),
            Flexible(
              child: Text(
                title,
                style: context.appTextTheme.bodySmall?.copyWith(
                  color: AppColorTheme.text,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
