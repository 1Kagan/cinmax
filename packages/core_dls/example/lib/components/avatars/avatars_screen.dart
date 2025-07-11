import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class AvatarsScreen extends StatelessWidget {
  const AvatarsScreen({super.key});

  NetworkImage image(int size) =>
      NetworkImage('https://i.pravatar.cc/${size * 100}');

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Avatar',
      body: ListView(
        children: [
          _buildAvatar(
            context,
            avatar: Avatar.small(image: image(32)),
            title: 'Small',
          ),
          _buildAvatar(
            context,
            avatar: Avatar.regular(image: image(48)),
            title: 'Regular',
          ),
          _buildAvatar(
            context,
            avatar: Avatar.large(image: image(64)),
            title: 'Large',
          ),
          SizedBox(height: 16.h),
          ProfilePhoto(
            image: image(64),
            title: 'Change Profile Photo',
            subtitle: 'Tap the icon to change it.',
          ),
          SizedBox(height: 16.h),
          const ProfilePhoto.empty(
            emptyTitle: 'Upload Profile Photo',
            emptySubtitle: 'Max.upload file size: 2MB',
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context, {
    required Widget avatar,
    required String title,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.appTextTheme.xSmallEmphasis,
          ),
          SizedBox(height: 4.h),
          avatar,
          SizedBox(height: 16.h),
        ],
      );
}
