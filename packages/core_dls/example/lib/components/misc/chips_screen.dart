import 'package:flutter/material.dart';
import 'package:core_dls/core_dls.dart';

class ChipsScreen extends StatelessWidget {
  const ChipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubPageLayout(
      title: 'Chips',
      body: Chips(
        chipText: "Cancelled",
      ),
    );
  }
}
