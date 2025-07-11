import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

class AppointmentCardsScreen extends StatelessWidget {
  const AppointmentCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageLayout(
      title: "Appointments Upcoming Card",
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              UpcomingAppointmentCard(
                title: "Information",
                onTap: () {},
                date: DateTime.now(),
                location: "Zorlu AVM",
              ),
              SizedBox(
                height: 18.0.h,
              ),
              PastAppointmentCard(
                title: "Information",
                location: "Zorlu AVM",
                date: DateTime.now(),
                onTap: () {},
              )
            ],
          )),
    );
  }
}
