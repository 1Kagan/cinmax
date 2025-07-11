import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/src/components/appointment/pop_up/widgets/pop_up_body.dart';

enum AppointmentPopUpType { reminder, positive, negative }

class AppointmentPopUp extends StatefulWidget {
  final AppointmentPopUpType level;
  final String title;
  final String subTitle;
  final Color backgroundColor;

  const AppointmentPopUp.positive({
    super.key,
    this.level = AppointmentPopUpType.positive,
    required this.subTitle,
    required this.title,
    required this.backgroundColor,
  });

  const AppointmentPopUp.reminder({
    super.key,
    this.level = AppointmentPopUpType.reminder,
    required this.subTitle,
    required this.title,
    required this.backgroundColor,
  });

  const AppointmentPopUp.negative({
    super.key,
    this.level = AppointmentPopUpType.negative,
    required this.subTitle,
    required this.title,
    required this.backgroundColor,
  });

  @override
  State<AppointmentPopUp> createState() => _AppointmentPopUpState();
}

class _AppointmentPopUpState extends State<AppointmentPopUp> {
  @override
  Widget build(BuildContext context) {
    return AppointmentPopUpBody(
      title: widget.title,
      subTitle: widget.subTitle,
      backgroundColor: widget.backgroundColor,
      headerIcon: _headerIcon(),
    );
  }

  Widget _headerIcon() {
    return Column(
      children: [
        if (widget.level == AppointmentPopUpType.reminder)
          Icon(
            Icons.info_outline_rounded,
            size: 26.67.r,
            color: Colors.white,
          ),
        if (widget.level == AppointmentPopUpType.negative)
          Icon(
            Icons.check_circle_outline,
            size: 26.67.r,
            color: Colors.white,
          ),
        if (widget.level == AppointmentPopUpType.positive)
          Icon(
            Icons.check_circle_outline,
            size: 26.67.r,
            color: Colors.white,
          ),
      ],
    );
  }
}
