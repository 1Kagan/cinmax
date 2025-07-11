import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/app_bar/bottom_sheet_appbar.dart';

class BottomSheetLayout extends StatelessWidget {
  const BottomSheetLayout({
    required this.body,
    super.key,
    this.bottomNavigationBar,
    this.title,
    this.bodyPadding,
    this.backgroundColor,
    this.onBackTapped,
    this.onDoneTapped,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final EdgeInsets? bodyPadding;
  final String? title;
  final Color? backgroundColor;
  final VoidCallback? onBackTapped;
  final VoidCallback? onDoneTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: BottomSheetAppBar(
        title: title,
        onDoneTapped: onDoneTapped,
        onBackTapped: onBackTapped,
      ),
      body: Padding(
        padding: bodyPadding ??
            const EdgeInsets.only(left: 24, right: 24, bottom: 24).r,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
