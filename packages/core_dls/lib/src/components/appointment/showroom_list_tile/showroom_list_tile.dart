import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class ShowroomListTile<T> extends StatelessWidget {
  const ShowroomListTile({
    super.key,
    required this.radioWidgetsParameters,
  });

  final RadioWidgetsParameters<String> radioWidgetsParameters;

  bool get isSelected =>
      radioWidgetsParameters.value == radioWidgetsParameters.groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          radioWidgetsParameters.onChanged(radioWidgetsParameters.value),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (radioWidgetsParameters.title != null) ...[
                      Text(
                        radioWidgetsParameters.title!,
                        style: context.appTextTheme.body!.copyWith(
                          color: AppColorTheme.orange80,
                        ),
                      ),
                    ],
                    if (radioWidgetsParameters.subTitle != null) ...[
                      Text(
                        radioWidgetsParameters.subTitle!,
                        style: context.appTextTheme.bodySmall!.copyWith(),
                        maxLines: 3,
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Text(
                      radioWidgetsParameters.date!,
                      style: context.appTextTheme.xSmallRegular!.copyWith(
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
              8.horizontalSpace,
              _generateRadioIcon,
            ],
          ),
          const ListTileDivider(),
        ],
      ),
    );
  }

  Widget get _generateRadioIcon {
    if (isSelected) {
      return DLSAssets.icons.toggleOn.svg(
        height: 24,
      );
    } else {
      return DLSAssets.icons.toggleOff.svg(
        height: 24,
      );
    }
  }
}
