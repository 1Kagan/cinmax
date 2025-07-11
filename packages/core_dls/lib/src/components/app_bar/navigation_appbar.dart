import 'package:flutter/material.dart';
import 'package:core_dls/src/constants/assets.gen.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationAppBar({
    super.key,
    this.titleKey,
    this.title = '',
    this.backBtnKey,
    this.onBackBtnPressed,
    this.height = kToolbarHeight,
    this.titleImage,
    this.hasBackButton = true,
  });

  final String title;
  final Key? titleKey;
  final Key? backBtnKey;
  final VoidCallback? onBackBtnPressed;
  final double height;
  final Widget? titleImage;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            child: Container(
              height: kToolbarHeight,
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: titleImage ??
                  Text(
                    title,
                    key: titleKey,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                  ),
            ),
          ),
          Visibility(
            visible: hasBackButton,
            child: GestureDetector(
              key: backBtnKey,
              onTap: onBackBtnPressed == null
                  ? () => Navigator.of(context).pop()
                  : () => onBackBtnPressed?.call(),
              child: DLSAssets.icons.arrowLeft.svg(
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
