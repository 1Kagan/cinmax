import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class ToastMessages extends StatelessWidget {
  const ToastMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: 'Toasts',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: Column(
          children: [
            PrimaryButton(
              margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
              text: 'Informative Toast',
              onTap: () {
                context.showInformativeToast("Message",
                    gravity: ToastGravity.TOP);
              },
            ),
            PrimaryButton(
              margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
              text: 'Positive Toast',
              onTap: () {
                context.showPositiveToast(
                  "Message",
                );
              },
            ),
            PrimaryButton(
              margin: EdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
              text: 'Negative Toast',
              onTap: () {
                context.showNegativeToast(
                  "Message",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
