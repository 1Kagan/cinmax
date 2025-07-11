import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

import '../../../feedbacks/bottom_sheet/widgets/close_icon.dart';

class AppointmentPopUpBody extends StatelessWidget {
  const AppointmentPopUpBody({
    super.key,
    required this.title,
    required this.subTitle,
    required this.backgroundColor,
    required this.headerIcon,
  });

  final String title;
  final String subTitle;
  final Color backgroundColor;
  final Widget headerIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 14,
            color: Colors.black.withOpacity(0.3),
          )
        ],
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.r),
            child: CloseIcon(
              iconColor: AppColorTheme.newGrey,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: headerIcon),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.appTextTheme.button?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColorTheme.newGrey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      width: 245.w,
                      child: Text(
                        subTitle,
                        style: context.appTextTheme.bodySmall?.copyWith(
                          color: AppColorTheme.newGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
