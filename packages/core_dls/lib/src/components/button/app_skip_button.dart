import 'package:flutter/material.dart';
import '../../localization/localization.dart';
import '../../theme/app_color_theme.dart';
import '../../theme/app_text_theme.dart';

class AppSkipButton extends StatelessWidget {
  const AppSkipButton({
    super.key,
    this.onPressed,
    this.title,
    this.darkMode = true,
  });

  final String? title;
  final VoidCallback? onPressed;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title ?? context.localization.skip,
        style: context.appTextTheme.button?.copyWith(
          color: darkMode ? AppColorTheme.pureWhite : AppColorTheme.darkBg,
        ),
      ),
    );
  }
}
