import 'package:flutter/material.dart';
import 'package:flutter_base/src/core/cubit/app_language/app_language_cubit.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportHelper {
  const SupportHelper._();

  static void openSupportChat({
    required BuildContext context,
  }) {
    // TODO(Kagan): implement openSupportChat
  }

  static Future<void> openForgotPasswordUrl() async {
    final deviceLanguage =
        injector<AppLanguageCubit>().state.appLanguage.languageCode;

    final uri = switch (deviceLanguage) {
      'tr' => 'https://example.com/tr/forgot-password',
      'en' => 'https://example.com/en/forgot-password',
      'it' => 'https://example.com/it/forgot-password',
      'zh' => 'https://example.com/zh/forgot-password',
      _ => 'https://example.com/en/forgot-password',
    };

    final url = Uri.parse(uri);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch the forgot password URL: $uri');
    }
  }
}
