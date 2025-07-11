import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

enum BadgeType { earned, isNotEarned, locked }

class BadgeTile extends StatelessWidget {
  const BadgeTile.isEarned({
    super.key,
    this.text,
    required this.icon,
    this.badgeType = BadgeType.earned,
  });

  const BadgeTile.isNotEarned({
    super.key,
    this.text,
    required this.icon,
    this.badgeType = BadgeType.isNotEarned,
  });

  const BadgeTile.locked({
    super.key,
    this.text,
    required this.icon,
    this.badgeType = BadgeType.locked,
  });

  final String? text;
  final BadgeType badgeType;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorTheme.pureWhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColorTheme.gray100),
      ),
      child: text != null
          ? Column(
              children: [
                SizedBox(height: 21.5.h),
                Flexible(flex: 1, child: _createIcon()),
                Padding(
                  padding: const EdgeInsets.only(top: 9.5),
                  child: Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: context.appTextTheme.bodySmall?.copyWith(
                      color: AppColorTheme.text,
                    ),
                  ),
                ),
              ],
            )
          : Center(child: _createIcon()),
    );
  }

  Color? _iconBackgroundColor() {
    switch (badgeType) {
      case BadgeType.earned:
        return AppColorTheme.iconGray;
      case BadgeType.isNotEarned:
        return AppColorTheme.darkBg;
      case BadgeType.locked:
        return AppColorTheme.iconGray;
      default:
        return null;
    }
  }

  Widget _createIcon() {
    switch (badgeType) {
      case BadgeType.isNotEarned:
        return CircleAvatar(
          backgroundColor: _iconBackgroundColor(),
          radius: 25.r,
          child: icon,
        );
      case BadgeType.earned:
        return icon;
      case BadgeType.locked:
        return icon;
      default:
        return icon;
    }
  }
}
