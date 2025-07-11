import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class LocationListTile extends StatelessWidget {
  final String availableHours;
  final String address;
  final String addressHeader;
  final String city;
  final Widget icon;

  const LocationListTile({
    super.key,
    required this.addressHeader,
    required this.city,
    required this.availableHours,
    required this.address,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 201.h,
      width: 342.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  addressHeader,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColorTheme.orange80,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    address,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColorTheme.appointmentText),
                  ),
                  SizedBox(width: 90.w),
                  icon,
                ],
              ),
              Text(
                city,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColorTheme.appointmentText),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                child: Text(
                  availableHours,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColorTheme.appointmentText),
                ),
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
