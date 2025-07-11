import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core_dls/core_dls.dart';

/// SubPageLayout is a Scaffold with a custom AppBar and a custom body padding
class SubPageLayout extends StatelessWidget {
  const SubPageLayout({
    super.key,
    required this.body,
    required this.title,
    this.lightStatusBar = false,
    this.titleScaler,
    this.floatingActionButton,
    this.titleKey,
    this.backButtonKey,
    this.onBack,
    this.isBackActionEnabled,
    this.extendBody = false,
    this.backgroundColor,
    this.bodyPadding,
    this.appbarColor,
    this.resizeToAvoidBottomInset,
    this.actions = const [],
    this.bottomNavigationBar,
    this.titleColor = AppColorTheme.pureBlack,
    this.titleStyle,
    this.iconColor = Colors.black,
    this.isPinned = true,
    this.physics,
    this.isTitleEditable = false,
    this.backIcon,
    this.keyboardDismissBehavior = KeyboardDismissBehavior.whenTapped,
    this.removeTitle = false,
    this.titleWidget,
    this.appBarHeight,
  }) : isSliver = false;

  const SubPageLayout.sliver({
    super.key,
    required this.title,
    required this.body,
    this.titleScaler,
    this.lightStatusBar = false,
    this.floatingActionButton,
    this.titleKey,
    this.backButtonKey,
    this.onBack,
    this.isBackActionEnabled,
    this.extendBody = false,
    this.backgroundColor,
    this.bodyPadding,
    this.appbarColor,
    this.resizeToAvoidBottomInset,
    this.actions = const [],
    this.bottomNavigationBar,
    this.titleColor,
    this.titleStyle,
    this.iconColor = Colors.black,
    this.isPinned = true,
    this.physics,
    this.isTitleEditable = false,
    this.backIcon,
    this.keyboardDismissBehavior = KeyboardDismissBehavior.whenTapped,
    this.removeTitle = false,
    this.titleWidget,
    this.appBarHeight,
  }) : isSliver = true;

  /// SubpageLayout has default padding around the [body] widget.
  /// Set this parameter to override it
  final EdgeInsets? bodyPadding;

  final bool lightStatusBar;
  final Key? titleKey;
  final Key? backButtonKey;

  /// Function to call when the back button is pressed
  final VoidCallback? onBack;

  /// The title of the page
  final String title;

  final TextScaler? titleScaler;

  /// The body of the page
  final Widget body;

  /// Icon that sits at the bottom right of the screen
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool? resizeToAvoidBottomInset;

  /// The background color of the page above and below the appbar
  final Color? backgroundColor;

  /// The color of the appbar
  final Color? appbarColor;

  /// The actions to display in the appbar on the top right
  final List<Widget> actions;

  final bool isSliver;
  final Widget? bottomNavigationBar;
  final Color? titleColor;
  final Color iconColor;
  final bool isPinned;

  /// The physics of the ScrollView
  final ScrollPhysics? physics;

  /// Whether the title is editable
  final bool isTitleEditable;

  /// The [TextStyle] of the title
  final TextStyle? titleStyle;

  /// Whether the back button is enabled
  final bool? isBackActionEnabled;

  /// The icon to display as the back button
  final SvgPicture? backIcon;
  final KeyboardDismissBehavior keyboardDismissBehavior;

  /// Whether to remove the title from the appbar, AppBar is thinner when title is removed
  final bool removeTitle;

  /// Widget in the Subpage Bar which replaces the title text
  final Widget? titleWidget;

  final double? appBarHeight;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor:
            appbarColor ?? Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: appbarColor,
        statusBarBrightness:
            lightStatusBar ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
            lightStatusBar ? Brightness.dark : Brightness.light,
      ),
      child: isSliver
          ? Scaffold(
              extendBody: extendBody,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              floatingActionButton: floatingActionButton,
              backgroundColor:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              body: GestureDetector(
                onTap: () {
                  if (FocusScope.of(context).hasFocus &&
                      keyboardDismissBehavior ==
                          KeyboardDismissBehavior.whenTapped) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: NestedScrollView(
                  physics: physics,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverOverlapAbsorber(
                          sliver: SliverSafeArea(
                            top: false,
                            bottom: false,
                            right: false,
                            left: false,
                            sliver: SliverAppBar.medium(
                              pinned: true,
                              floating: false,
                              surfaceTintColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              backgroundColor: appbarColor ??
                                  Theme.of(context).scaffoldBackgroundColor,
                              expandedHeight: appBarHeight ?? 100.h,
                              title: Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        title,
                                        key: titleKey,
                                        style:
                                            context.appTextTheme.h1?.copyWith(
                                          color: titleColor ??
                                              Theme.of(context)
                                                  .textTheme
                                                  .displayLarge!
                                                  .color!,
                                          fontSize: 20.sp,
                                        ),
                                        textScaler: titleScaler,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              leading: GestureDetector(
                                key: backButtonKey,
                                onTap: onBack ?? () => Navigator.pop(context),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 27.w),
                                  child: SizedBox(
                                    height: 32.h,
                                    width: 32.h,
                                    child: Center(
                                      child: DLSAssets.icons.arrowLeft.svg(
                                        height: 24.h,
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).iconTheme.color!,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: actions,
                            ),
                          ),
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context)),
                    ];
                  },
                  body: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Padding(
                      padding: bodyPadding ??
                          EdgeInsets.only(
                            left: 24.w,
                            right: 24.w,
                          ),
                      child: body,
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar,
            )
          : Scaffold(
              extendBody: extendBody,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              floatingActionButton: floatingActionButton,
              backgroundColor:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              appBar: SubPageAppBar(
                onBack: onBack,
                color: appbarColor ?? Theme.of(context).scaffoldBackgroundColor,
                title: title,
                titleColor: Theme.of(context).textTheme.displayLarge!.color!,
                titleStyle: titleStyle,
                iconColor: Theme.of(context).iconTheme.color!,
                titleKey: titleKey,
                isBackActionEnabled: isBackActionEnabled ?? true,
                backIcon: backIcon,
                backButtonKey: backButtonKey,
                actions: actions,
                removeTitle: removeTitle,
                titleWidget: titleWidget,
              ),
              body: GestureDetector(
                onTap: () {
                  if (FocusScope.of(context).hasFocus &&
                      keyboardDismissBehavior ==
                          KeyboardDismissBehavior.whenTapped) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: Padding(
                  padding: bodyPadding ??
                      EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 16.h,
                      ),
                  child: body,
                ),
              ),
              bottomNavigationBar: bottomNavigationBar,
            ),
    );
  }
}

enum KeyboardDismissBehavior {
  /// The keyboard will dismiss when the user taps the main body of the Scaffold.
  whenTapped,

  /// The keyboard will not dismiss automatically.
  none,
}
