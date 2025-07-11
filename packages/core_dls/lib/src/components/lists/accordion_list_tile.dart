import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class AccordionListTile extends StatefulWidget {
  const AccordionListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.child,
  });

  final String title;
  final String? subtitle;
  final Widget? child;

  @override
  State<AccordionListTile> createState() => _AccordionListTileState();
}

class _AccordionListTileState extends State<AccordionListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        style: context.appTextTheme.bodySmallEmphasis,
      ),
      tilePadding: EdgeInsets.zero,
      subtitle: isExpanded
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: (widget.child ??
                  Text(
                    widget.subtitle ?? '',
                    style: context.appTextTheme.xSmallRegular,
                  )),
            )
          : null,
      trailing: isExpanded
          ? DLSAssets.icons.minus.svg(
              width: 24,
              colorFilter: const ColorFilter.mode(
                AppColorTheme.text,
                BlendMode.srcIn,
              ),
            )
          : DLSAssets.icons.add.svg(
              width: 24,
              colorFilter: const ColorFilter.mode(
                AppColorTheme.text,
                BlendMode.srcIn,
              ),
            ),
      onExpansionChanged: (value) {
        setState(() => isExpanded = !isExpanded);
      },
    );
  }
}
