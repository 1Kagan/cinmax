import 'package:example/constants/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Onboarding',
      body: SizedBox(
        height: 400.h,
        child: OnboardingCard(
          currentIndexOnTap: (index) {
            debugPrint('index: $index');
          },
          items: [
            OnboardCardItem(
                imagePath: Assets.images.magnetOnboardBg1.path,
                title: 'Magnet 1',
                content:
                    'Magnet is a digital wallet that allows you to store, send and receive digital currencies.',
                buttonName: 'button'),
            OnboardCardItem(
              imagePath: Assets.images.magnetOnboardBg2.path,
              title: 'Magnet 2',
              content:
                  'Magnet is a digital wallet that allows you to store, send and receive digital currencies.',
            ),
            OnboardCardItem(
              imagePath: Assets.images.magnetOnboardBg3.path,
              title: 'Magnet 3',
              content:
                  'Magnet is a digital wallet that allows you to store, send and receive digital currencies.',
            ),
          ],
        ),
      ),
    );
  }
}
