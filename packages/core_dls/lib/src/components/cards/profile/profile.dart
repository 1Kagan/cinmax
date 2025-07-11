import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.currentLevel,
    required this.currentPoint,
    required this.nextLevelPoint,
    required this.icon,
  });

  final String currentLevel;
  final int currentPoint;
  final int nextLevelPoint;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      height: 104.h,
      width: 342.w,
      decoration: BoxDecoration(
        color: AppColorTheme.darkBg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentLevel,
                        textAlign: TextAlign.end,
                        style: context.appTextTheme.body?.copyWith(
                          color: AppColorTheme.pureWhite,
                        ),
                      ),
                      Text(
                        "$currentPoint Points",
                        style: context.appTextTheme.bodySmall?.copyWith(
                          color: AppColorTheme.pureWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Next Level",
                    textAlign: TextAlign.end,
                    style: context.appTextTheme.body?.copyWith(
                      color: AppColorTheme.pureWhite,
                    ),
                  ),
                  Text(
                    "$nextLevelPoint Points",
                    style: context.appTextTheme.bodySmall?.copyWith(
                      color: AppColorTheme.pureWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
            child: LinearProgressIndicator(
              backgroundColor: AppColorTheme.pureWhite,
              color: AppColorTheme.orange80,
              minHeight: 8.h,
              value: currentPoint / nextLevelPoint,
            ),
          ),
        ],
      ),
    );
  }
}
