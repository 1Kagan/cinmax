import 'package:flutter/material.dart';

class RadioWidgetsParameters<T> {
  RadioWidgetsParameters({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.subTitle,
    this.date,
  });

  final T value;
  final T groupValue;
  final String? title;
  final String? subTitle;
  String? date;
  final ValueChanged<T?> onChanged;
}
