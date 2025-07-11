import 'dart:ui';

class LanguageUtil {
  static String getLangId(String currentLangCode) {
    switch (currentLangCode) {
      case 'en':
        return '3241';
      case 'tr':
        return '3710';
      default:
        return '3241'; // Default language ID
    }
  }

  static String getDeviceLanguageCode() {
    final languageCode = PlatformDispatcher.instance.locale.languageCode;
    switch (languageCode) {
      case 'en':
        return 'en';
      case 'tr':
        return 'tr';
      default:
        return 'en';
    }
  }
}
