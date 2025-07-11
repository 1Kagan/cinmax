import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/localization/localization.dart';
import 'package:core_dls/core_dls.dart';

class PastAppointmentCard extends StatelessWidget {
  const PastAppointmentCard({
    super.key,
    required this.location,
    required this.date,
    required this.title,
    required this.onTap,
  });

  final String location;
  final DateTime date;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: AppColorTheme.gray100,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            _LocationInformation(date: date),
            Divider(
              height: 1.h,
              color: AppColorTheme.gray100,
            ),
            _InformationCard(title: title, location: location),
          ],
        ),
      ),
    );
  }
}

class _LocationInformation extends StatelessWidget {
  const _LocationInformation({
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          DLSAssets.icons.notificationStatus.svg(height: 18.h),
          SizedBox(width: 8.w),
          Text(
            DateFormat(context.localization.dateFormatYyyyMmmmDdHhMm,
                    Localizations.localeOf(context).languageCode)
                .format(date),
            style: context.appTextTheme.bodySmall!.copyWith(
              color: AppColorTheme.appointmentText,
            ),
          ),
        ],
      ),
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    required this.title,
    required this.location,
  });

  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 7.w,
        top: 12.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.appTextTheme.button!.copyWith(
                  color: AppColorTheme.appointmentText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  DLSAssets.icons.signpost
                      .svg(height: 15.h, width: 12.w),
                  SizedBox(width: 10.w),
                  Text(
                    location,
                    style: context.appTextTheme.bodySmall!.copyWith(
                      color: AppColorTheme.appointmentText,
                    ),
                  ),
                ],
              )
            ],
          ),
          DLSAssets.icons.arrowRight.svg(height: 24.w),
        ],
      ),
    );
  }
}
