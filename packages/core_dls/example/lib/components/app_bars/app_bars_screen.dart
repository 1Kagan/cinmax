import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

import '../../constants/assets.gen.dart';

class AppbarsScreen extends StatefulWidget {
  const AppbarsScreen({super.key});

  @override
  State<AppbarsScreen> createState() => _AppbarsScreenState();
}

class _AppbarsScreenState extends State<AppbarsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 230, 230),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Appbars',
          style: context.appTextTheme.h1?.copyWith(color: AppColorTheme.darkBg),
        ),
      ),
      body: ListView(
        children: [
          addTitle(
            title: 'Main Node',
            child: MainNodeAppBar(
              // appBarColor: AppColorTheme.darkBg,
              images: [Assets.images.magnetOnboardBg2.image()],
            ),
          ),
          24.verticalSpace,
          SubPageAppBar(title: 'Wallet'),
          24.verticalSpace,
          BottomSheetAppBar(
            title: 'BottomSheetAppBar',
            onDoneTapped: () {},
          ),
          24.verticalSpace,
          BottomSheetAppBar(
            onBackTapped: () {},
            onDoneTapped: () {},
          ),
          24.verticalSpace,
          BottomSheetAppBar(
            title: 'BottomSheetAppBar',
            onDoneTapped: () {},
            darkMode: true,
          ),
          24.verticalSpace,
          BottomSheetAppBar(
            onBackTapped: () {},
            onDoneTapped: () {},
            darkMode: true,
          ),
        ],
      ),
    );
  }

  Widget addTitle({
    String? title,
    required Widget child,
    bool darkMode = false,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.r,
              vertical: 5.r,
            ),
            child: Text(
              title ?? '',
              style: context.appTextTheme.h2?.copyWith(
                color: darkMode ? AppColorTheme.pureWhite : AppColorTheme.darkBg,
              ),
            ),
          ),
          SizedBox(height: 20.r),
          child,
          SizedBox(height: 20.r),
        ],
      );
}
