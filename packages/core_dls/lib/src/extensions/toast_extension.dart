import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:core_dls/src/components/feedbacks/toasts/toasts.dart';

extension ToastExtension on BuildContext {
  FToast get _ftst => FToast()..init(this);

  showInformativeToast(
    String title, {
    Duration duration = const Duration(
      seconds: 2,
    ),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) =>
      _ftst
        ..removeQueuedCustomToasts()
        ..showToast(
          child: Toasts.informative(
            title: title,
          ),
          gravity: gravity,
          toastDuration: duration,
        );

  showPositiveToast(
    String title, {
    Duration duration = const Duration(
      seconds: 2,
    ),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) =>
      _ftst
        ..removeQueuedCustomToasts()
        ..showToast(
          child: Toasts.positive(
            title: title,
          ),
          gravity: gravity,
          toastDuration: duration,
        );

  showNegativeToast(
    String title, {
    Duration duration = const Duration(
      seconds: 2,
    ),
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) =>
      _ftst
        ..removeQueuedCustomToasts()
        ..showToast(
          child: Toasts.negative(
            title: title,
          ),
          gravity: gravity,
          toastDuration: duration,
        );
}
