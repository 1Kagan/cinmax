import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  const UpcomingAppointmentCard({
    super.key,
    this.title,
    required this.date,
    required this.location,
    required this.onTap,
    this.plate,
    this.child,
    this.appointmentType,
    this.appointmentStatus,
    this.arrowIcon = true,
  });

  final String? title;
  final Widget? plate;
  final DateTime date;
  final String location;
  final VoidCallback onTap;
  final Widget? child;
  final Widget? appointmentType;
  final Widget? appointmentStatus;
  final bool arrowIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColorTheme.gray,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColorTheme.darkBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              height: 118.h,
              width: 106.w,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColorTheme.newGrey,
                        shape: BoxShape.circle,
                      ),
                      child: child ??
                          Text(
                            date.day.toString(),
                            style: context.appTextTheme.h1!.copyWith(
                              color: AppColorTheme.appointmentText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                    ),
                    4.verticalSpace,
                    appointmentType ??
                        Text(
                          DateFormat(
                            "MMMM",
                            Localizations.localeOf(context).languageCode,
                          ).format(date).toUpperCase(),
                          style: context.appTextTheme.bodySmall!.copyWith(
                            color: AppColorTheme.newGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    plate ??
                        Text(
                          date.year.toString(),
                          style: context.appTextTheme.bodySmall!.copyWith(
                            color: AppColorTheme.newGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 118.h,
              width: 227.w,
              child: Padding(
                padding: EdgeInsets.only(left: 14.0.w, right: 14.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appointmentStatus ??
                            Text(
                              title!,
                              style: context.appTextTheme.button!.copyWith(
                                color: AppColorTheme.appointmentText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        Row(
                          children: [
                            DLSAssets.icons.location
                                .svg(height: 15.h, width: 12.w),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 165.w,
                              child: Text(
                                location,
                                style: context.appTextTheme.bodySmall!.copyWith(
                                  color: AppColorTheme.appointmentText,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    if (arrowIcon != false) ...[
                      DLSAssets.icons.locationMinus
                          .svg(height: 15.h, width: 12.w),
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
