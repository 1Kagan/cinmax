import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.height = 60,
    this.color,
    this.padding = 16,
  });

  final double height;
  final Color? color;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding.r),
      child: Center(
        child: SizedBox(
          height: height.w,
          width: height.w,
          child: CircularProgressIndicator(
            color: color,
          ),
        ),
      ),
    );
  }
}
