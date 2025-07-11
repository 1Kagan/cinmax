import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/theme/app_color_theme.dart';

class AppRadioButton<T> extends StatelessWidget {
  const AppRadioButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.size = 24,
  });

  final void Function(T? p1)? onChanged;
  final T value;
  final T groupValue;
  final double size;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged?.call(value),
      child: Container(
        width: size.r,
        height: size.r,
        padding: EdgeInsets.all(1).r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColorTheme.gray200,
            width: 1,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColorTheme.orange : null,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
