import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class CloseLabelIcon extends StatelessWidget {
  const CloseLabelIcon({
    super.key,
    required this.onTap,
    required this.labelText,
  });

  final VoidCallback onTap;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        labelText,
        style: context.appTextTheme.body?.copyWith(
          color: AppColorTheme.text,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
