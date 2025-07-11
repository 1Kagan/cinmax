import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/feedbacks/bottom_sheet/widgets/close_label_icon.dart';
import 'package:core_dls/src/theme/app_text_theme.dart';

import '../components/button/primary_button.dart';
import '../components/button/secondary_button.dart';
import '../components/feedbacks/bottom_sheet/app_bottom_sheet.dart';
import '../components/feedbacks/bottom_sheet/widgets/close_icon.dart';
import '../theme/app_color_theme.dart';

extension BottomSheetX on BuildContext {
  showInformativeBottomSheet({
    required String title,
    dynamic subTitle,
    required String buttonLabel,
    VoidCallback? onButtonTap,
    VoidCallback? onCloseButtonTap,
    bool popAfterButtonTapped = true,
    SecondaryButtonType secondaryButtonType = SecondaryButtonType.normal,
    bool isDismissible = true,
    String? secondButtonLabel,
    void Function()? onSecondButtonTap,
    bool? darkMode,
    Color backgroundColor = AppColorTheme.pureWhite,
  }) =>
      showModalBottomSheet<void>(
        backgroundColor: backgroundColor,
        isScrollControlled: true,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return AppBottomSheet.informative(
            buttonLabel: buttonLabel,
            title: title,
            subtitle: subTitle,
            secondButtonLabel: secondButtonLabel,
            onSecondButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onSecondButtonTap?.call();
            },
            onCloseButtonTap: !isDismissible
                ? null
                : () {
                    Navigator.of(context).pop();
                    onCloseButtonTap?.call();
                  },
            onButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onButtonTap?.call();
            },
            secondaryButtonType: secondaryButtonType,
            darkMode: darkMode ?? false,
          );
        },
      );

  showPositiveBottomSheet({
    required String title,
    dynamic subTitle,
    String? buttonLabel,
    bool popAfterButtonTapped = true,
    VoidCallback? onButtonTap,
    VoidCallback? onCloseButtonTap,
    bool isDismissible = true,
    String? secondButtonLabel,
    void Function()? onSecondButtonTap,
    SecondaryButtonType secondaryButtonType = SecondaryButtonType.normal,
    bool? darkMode,
    Color backgroundColor = AppColorTheme.pureWhite,
  }) =>
      showModalBottomSheet<void>(
        backgroundColor: backgroundColor,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return AppBottomSheet.positive(
            buttonLabel: buttonLabel,
            title: title,
            subtitle: subTitle,
            secondButtonLabel: secondButtonLabel,
            onSecondButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onSecondButtonTap?.call();
            },
            secondaryButtonType: secondaryButtonType,
            onCloseButtonTap: !isDismissible
                ? null
                : () {
                    Navigator.of(context).pop();
                    onCloseButtonTap?.call();
                  },
            onButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onButtonTap?.call();
            },
            darkMode: darkMode,
          );
        },
      );

  showNegativeBottomSheet({
    required String title,
    dynamic subTitle,
    String? buttonLabel,
    bool popAfterButtonTapped = false,
    VoidCallback? onButtonTap,
    VoidCallback? onCloseButtonTap,
    bool isDismissible = true,
    String? secondButtonLabel,
    SecondaryButtonType secondaryButtonType = SecondaryButtonType.normal,
    void Function()? onSecondButtonTap,
    bool? darkMode,
    Color backgroundColor = AppColorTheme.pureWhite,
  }) =>
      showModalBottomSheet<void>(
        backgroundColor: backgroundColor,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return AppBottomSheet.negative(
            buttonLabel: buttonLabel,
            title: title,
            secondButtonLabel: secondButtonLabel,
            onSecondButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onSecondButtonTap?.call();
            },
            secondaryButtonType: secondaryButtonType,
            subtitle: subTitle,
            onCloseButtonTap: !isDismissible
                ? null
                : () {
                    Navigator.of(context).pop();
                    onCloseButtonTap?.call();
                  },
            onButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onButtonTap?.call();
            },
            darkMode: darkMode,
          );
        },
      );

  showScrollableCustomBottomSheet({
    required String title,
    required Widget headerIcon,
    Color? titleColor,
    dynamic subTitle,
    String? buttonLabel,
    bool popAfterButtonTapped = true,
    VoidCallback? onButtonTap,
    VoidCallback? onCloseButtonTap,
    bool isDismissible = true,
    String? secondButtonLabel,
    void Function()? onSecondButtonTap,
    SecondaryButtonType secondaryButtonType = SecondaryButtonType.normal,
    bool? darkMode,
    Color backgroundColor = AppColorTheme.pureWhite,
  }) =>
      showModalBottomSheet<void>(
        backgroundColor: backgroundColor,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AppBottomSheet.custom(
              buttonLabel: buttonLabel,
              title: title,
              headerIcon: headerIcon,
              titleColor: titleColor,
              subtitle: subTitle,
              secondButtonLabel: secondButtonLabel,
              onSecondButtonTap: () {
                if (popAfterButtonTapped) {
                  Navigator.of(context).pop();
                }
                onSecondButtonTap?.call();
              },
              secondaryButtonType: secondaryButtonType,
              onCloseButtonTap: !isDismissible
                  ? null
                  : () {
                      Navigator.of(context).pop();
                      onCloseButtonTap?.call();
                    },
              onButtonTap: () {
                if (popAfterButtonTapped) {
                  Navigator.of(context).pop();
                }
                onButtonTap?.call();
              },
              darkMode: darkMode,
            ),
          );
        },
      );

  showCustomBottomSheet({
    required String title,
    required Widget headerIcon,
    Color? titleColor,
    dynamic subTitle,
    String? buttonLabel,
    bool popAfterButtonTapped = true,
    VoidCallback? onButtonTap,
    VoidCallback? onCloseButtonTap,
    bool isDismissible = true,
    String? secondButtonLabel,
    void Function()? onSecondButtonTap,
    SecondaryButtonType secondaryButtonType = SecondaryButtonType.normal,
    bool? darkMode,
    Color backgroundColor = AppColorTheme.pureWhite,
    Color? barrierColor,
  }) =>
      showModalBottomSheet<void>(
        backgroundColor: backgroundColor,
        barrierColor: barrierColor,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return AppBottomSheet.custom(
            buttonLabel: buttonLabel,
            title: title,
            headerIcon: headerIcon,
            titleColor: titleColor,
            subtitle: subTitle,
            secondButtonLabel: secondButtonLabel,
            onSecondButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onSecondButtonTap?.call();
            },
            secondaryButtonType: secondaryButtonType,
            onCloseButtonTap: !isDismissible
                ? null
                : () {
                    Navigator.of(context).pop();
                    onCloseButtonTap?.call();
                  },
            onButtonTap: () {
              if (popAfterButtonTapped) {
                Navigator.of(context).pop();
              }
              onButtonTap?.call();
            },
            darkMode: darkMode,
          );
        },
      );

  Future<void> showContentBottomSheet({
    required String title,
    required Widget content,
    required BuildContext context,
    TextStyle? titleTextStyle,
    String? buttonLabel,
    bool popAfterButtonTapped = false,
    void Function(BuildContext)? onButtonTap,
    VoidCallback? secondButtonOnTap,
    void Function(BuildContext)? onCloseButtonTap,
    bool? closeLabelIcon = false,
    String closeLabelText = 'Done',
    bool isDismissible = true,
    bool useButton = true,
    bool useSecondButton = false,
    bool useCloseButton = true,
    String? secondButtonLabel,
    BoxConstraints? constraints,
    double? height,
    bool? darkMode,
    Color? backgroundColor,
    Color? barrierColor,
  }) async =>
      await showModalBottomSheet<void>(
        backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        barrierColor: barrierColor,
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        isScrollControlled: true,
        context: this,
        useRootNavigator: true,
        clipBehavior: Clip.antiAlias,
        constraints: constraints,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: height,
              margin: EdgeInsets.all(24.r),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: titleTextStyle ??
                              context.appTextTheme.h2
                                  ?.copyWith(color: Theme.of(context).textTheme.headlineLarge?.color),
                        ),
                      ),
                      useCloseButton == true
                          ? closeLabelIcon == true
                              ? CloseLabelIcon(
                                  onTap: () => onCloseButtonTap?.call(context),
                                  labelText: closeLabelText,
                                )
                              : SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: CloseIcon(
                                    onTap: () =>
                                        onCloseButtonTap?.call(context),
                                  ),
                                )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  content,
                  if (useButton)
                    PrimaryButton(
                      text: buttonLabel ?? '',
                      onTap: () => onButtonTap?.call(context),
                      darkMode: darkMode ?? false,
                    ),
                  if (useSecondButton) ...[
                    12.verticalSpace,
                    Center(
                      child: GestureDetector(
                        onTap: secondButtonOnTap ?? () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.w),
                          child: Text(
                            secondButtonLabel ?? '',
                            style: context.appTextTheme.body?.copyWith(
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      );

  Future<void> showBottomSheetLayout({
    required Widget sheetLayout,
    bool isDismissible = true,
    double maxHeight = .9,
    double minHeight = .8,
    Color backgroundColor = AppColorTheme.pureWhite,
    Color? barrierColor,
  }) async {
    await showModalBottomSheet(
      context: this,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (ctx) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => sheetLayout,
          settings: settings,
        ),
        initialRoute: '/',
      ),
      useRootNavigator: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: maxHeight.sh,
        minHeight: minHeight.sh,
      ),
    );
  }
}



