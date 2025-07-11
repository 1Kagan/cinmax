import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  static bool get _isRunningUnitTest =>
      Platform.environment.containsKey('FLUTTER_TEST');

  static Future<void> show() async {
    if (_isRunningUnitTest) return;
    await EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static void hide() {
    if (_isRunningUnitTest) return;
    EasyLoading.dismiss();
  }
}
