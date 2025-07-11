import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class ButtonsScreen extends StatefulWidget {
  const ButtonsScreen({super.key});

  @override
  State<ButtonsScreen> createState() => _ButtonsScreenState();
}

class _ButtonsScreenState extends State<ButtonsScreen> {
  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      bodyPadding: EdgeInsets.zero,
      title: 'Buttons',
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _lightMode(),
          _darkMode(context),
        ],
      ),
    );
  }

  Widget _lightMode() {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        children: [
          addTitle(
            title: 'Primary Button',
            child: Column(
              children: [
                PrimaryButton(
                  text: 'Label',
                  onTap: () {},
                ),
                10.verticalSpace,
                const PrimaryButton(text: 'Label'),
                10.verticalSpace,
                PrimaryButton.async(
                  text: 'Async Label',
                  onTap: () async {
                    await Future.delayed(const Duration(seconds: 3), () {});
                  },
                ),
              ],
            ),
          ),
          addTitle(
            title: 'Secondary Button',
            child: Column(
              children: [
                SecondaryButton(
                  text: 'Label',
                  onTap: () {},
                ),
                10.verticalSpace,
                SecondaryButton.async(
                  text: 'Async Label',
                  onTap: () =>
                      Future.delayed(const Duration(seconds: 3), () {}),
                ),
                10.verticalSpace,
                const SecondaryButton(text: 'Label'),
                10.verticalSpace,
                SecondaryButton(
                  type: SecondaryButtonType.sensitive,
                  onTap: () {},
                  text: 'Label',
                ),
                10.verticalSpace,
                SecondaryButton.async(
                  type: SecondaryButtonType.sensitive,
                  onTap: () =>
                      Future.delayed(const Duration(seconds: 3), () {}),
                  text: 'Async Label',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _darkMode(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      color: AppColorTheme.darkBg,
      child: Column(
        children: [
          Text(
            'Dark Mode: true',
            style: context.appTextTheme.h1?.copyWith(
              color: AppColorTheme.pureWhite,
            ),
          ),
          SizedBox(height: 50.r),
          addTitle(
            darkMode: true,
            title: 'Primary Button',
            child: Column(
              children: [
                PrimaryButton(
                  text: 'Label',
                  onTap: () {},
                ),
                PrimaryButton(
                  margin: EdgeInsets.symmetric(vertical: 10.r),
                  text: 'Label',
                ),
              ],
            ),
          ),
          addTitle(
            darkMode: true,
            title: 'Secondary Button',
            child: Column(
              children: [
                SecondaryButton(
                  darkMode: true,
                  text: 'Label',
                  onTap: () {},
                ),
                SecondaryButton(
                  darkMode: true,
                  margin: EdgeInsets.symmetric(vertical: 10.r),
                  text: 'Label',
                ),
              ],
            ),
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
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: context.appTextTheme.h2?.copyWith(
                color:
                    darkMode ? AppColorTheme.pureWhite : AppColorTheme.darkBg,
              ),
            ),
            SizedBox(height: 25.r),
            child,
          ],
        ),
      );
}
