import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/avatars/avatar.dart';
import 'package:core_dls/src/constants/assets.gen.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    this.image,
    this.emptyTitle,
    this.emptySubtitle,
    this.title,
    this.subtitle,
    this.onTap,
  });

  const ProfilePhoto.empty({
    super.key,
    this.emptyTitle,
    this.emptySubtitle,
    this.onTap,
  })  : image = null,
        title = null,
        subtitle = null;

  final ImageProvider? image;
  final VoidCallback? onTap;
  final String? emptyTitle;
  final String? emptySubtitle;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return GestureDetector(
        onTap: onTap,
        child: _NoProfilePhoto(
          title: emptyTitle,
          subtitle: emptySubtitle,
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: _ProfilePhoto(
          image: image,
          title: title,
          subtitle: subtitle,
        ),
      );
    }
  }
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto({
    required this.image,
    this.title,
    this.subtitle,
  });

  final ImageProvider<Object>? image;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            Avatar.large(image: image!),
            // Positioned(
            //   right: -16,
            //   child: Assets.icons.checkCircle.svg(),
            // ),
          ],
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: context.appTextTheme.bodySmallEmphasis,
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle ?? '',
              style: context.appTextTheme.footnote,
            ),
          ],
        )
      ],
    );
  }
}

class _NoProfilePhoto extends StatelessWidget {
  const _NoProfilePhoto({
    this.title,
    this.subtitle,
  });

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _EmptyAvatar(),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: context.appTextTheme.xSmallEmphasis,
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle ?? '',
              style: context.appTextTheme.footnote,
            ),
          ],
        )
      ],
    );
  }
}

class _EmptyAvatar extends StatelessWidget {
  const _EmptyAvatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColorTheme.gray500,
              width: 2,
            ),
          ),
          width: 64.r,
          height: 64.r,
        ),
        DLSAssets.icons.instagram.svg(),
      ],
    );
  }
}
