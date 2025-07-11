import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

import '../../../constants/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Profile',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Profile(
          currentLevel: "1",
          currentPoint: 142,
          nextLevelPoint: 300,
          icon: Assets.images.medalIcon.svg(
            height: 26.67.h,
            width: 20.w,
          ),
        ),
      ),
    );
  }
}
