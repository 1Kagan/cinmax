import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class LocationCard extends StatelessWidget {
  final String availableHours;
  final String address;
  final String addressHeader;
  final String? title;
  final String firstSmallButtonText;
  final String? secondSmallButtonText;
  final VoidCallback? firstSmallButtonOnTap;
  final VoidCallback? secondSmallButtonOnTap;

  const LocationCard({
    super.key,
    this.title,
    required this.addressHeader,
    required this.availableHours,
    required this.address,
    required this.firstSmallButtonText,
    this.secondSmallButtonText,
    required this.firstSmallButtonOnTap,
    this.secondSmallButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? "Location",
              style: context.appTextTheme.body?.copyWith(
                  color: AppColorTheme.gray800,
                  fontWeight: FontWeight.w700,
                  fontSize: 18)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(addressHeader,
                    style: context.appTextTheme.body
                        ?.copyWith(color: AppColorTheme.gray800)),
              ),
              Text(address,
                  style: context.appTextTheme.bodySmall
                      ?.copyWith(color: AppColorTheme.appointmentText)),
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
                child: Text(availableHours,
                    style: context.appTextTheme.miniLabel?.copyWith(
                        color: AppColorTheme.gray800,
                        fontWeight: FontWeight.w400)),
              ),
              Row(
                children: [
                  Expanded(
                    child: SmallButton(
                      firstSmallButtonText,
                      onTap: firstSmallButtonOnTap,
                      icon: 'assets/icons/mail_icon.svg',
                    ),
                  ),
                  if (secondSmallButtonText != null) ...[
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SmallButton(
                        secondSmallButtonText,
                        onTap: secondSmallButtonOnTap,
                        icon: 'assets/icons/marker_icon.svg',
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
