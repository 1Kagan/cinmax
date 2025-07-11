import 'package:flutter/services.dart';
class PortraitModeUtil {
  static void onPopInvokedWithResult(bool shouldPop, dynamic result) {
    if (shouldPop) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }
}