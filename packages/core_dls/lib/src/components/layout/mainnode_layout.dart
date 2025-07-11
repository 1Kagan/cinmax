import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:core_dls/src/components/app_bar/mainnode_appbar.dart';

import '../../theme/app_color_theme.dart';

class MainNodeLayout extends StatelessWidget {
  const MainNodeLayout({
    super.key,
    required this.body,
    this.lightStatusBar = false,
    this.extendBody = false,
    this.appBarColor,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.hideAppBar = false,
    this.images,
    this.drawer,
    this.endDrawer,
    this.scaffoldKey,
    this.additionalWidgetForAppBar,
  });

  final bool lightStatusBar;
  final Color? appBarColor;
  final Widget body;
  final bool hideAppBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final bool extendBody;
  final List<Widget>? images;
  final Widget? drawer;
  final Widget? endDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? additionalWidgetForAppBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
        lightStatusBar ? AppColorTheme.pureWhite : AppColorTheme.pureBlack,
        statusBarBrightness:
        lightStatusBar ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
        lightStatusBar ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        key: scaffoldKey,
        appBar: hideAppBar
            ? null
            : MainNodeAppBar(
          // appBarColor: appBarColor,
          images: images,
          additionalWidget: additionalWidgetForAppBar, // Pass additionalWidget here
              ),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        extendBody: extendBody,
        endDrawer: endDrawer, // Here is the line to add
      ),
    );
  }
}