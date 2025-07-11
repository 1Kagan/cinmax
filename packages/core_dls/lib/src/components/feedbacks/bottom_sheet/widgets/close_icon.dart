import 'package:flutter/material.dart';
import 'package:core_dls/src/constants/assets.gen.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({
    super.key,
    required this.onTap,
    this.iconColor,
  });

  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Transform.rotate(
          angle: 3.14 / 4,
          child: InkWell(
            onTap: onTap,
            child: DLSAssets.icons.add.svg(
              colorFilter: ColorFilter.mode(
                iconColor ?? Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
