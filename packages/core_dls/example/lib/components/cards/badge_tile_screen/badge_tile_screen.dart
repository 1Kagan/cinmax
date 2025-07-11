import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

import '../../../constants/assets.gen.dart';

class BadgeTileScreen extends StatelessWidget {
  const BadgeTileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: "Badge Tile",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BadgeTile.isNotEarned(
              text: "Newcomer",
              icon: Assets.images.rocketIcon.svg(height: 60.27.h),
            ),
            SizedBox(height: 20.r),
            BadgeTile.locked(
              icon: Assets.images.lockIcon.svg(
                height: 40.h,
                width: 40.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
