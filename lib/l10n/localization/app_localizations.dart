import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalizations {
  AppLocalizations(this._localizedStrings);

  final Map<String, String> _localizedStrings;

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('tr'),
  ];

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  // Initialize translations from ARB files and save to secure storage
  static Future<void> initializeTranslations() async {
    const secureStorage = FlutterSecureStorage();

    // Try to load directly from assets folder first
    try {
      await _loadFromAssets('en', secureStorage);
      await _loadFromAssets('tr', secureStorage);
    } catch (e) {
      debugPrint('Failed to load from assets: $e');

      // If assets loading fails, try to load from lib folder
      try {
        await _loadFromLib('en', secureStorage);
        await _loadFromLib('tr', secureStorage);
      } catch (e) {
        debugPrint('Failed to load from lib: $e');
      }
    }
  }

  static Future<void> _loadFromAssets(
      String langCode, FlutterSecureStorage secureStorage) async {
    final assetPath = 'assets/l10n/app_$langCode.arb';
    final jsonString = await rootBundle.loadString(assetPath);
    await secureStorage.write(key: 'locale_$langCode', value: jsonString);
    debugPrint('Loaded $langCode translations from assets');
  }

  static Future<void> _loadFromLib(
      String langCode, FlutterSecureStorage secureStorage) async {
    final assetPath = 'lib/l10n/arb/app_$langCode.arb';
    final jsonString = await rootBundle.loadString(assetPath);
    await secureStorage.write(key: 'locale_$langCode', value: jsonString);
    debugPrint('Loaded $langCode translations from lib');
  }

  static Future<AppLocalizations> load(Locale locale) async {
    const secureStorage = FlutterSecureStorage();
    String? jsonString;
    Map<String, String> localizedStrings = {};

    try {
      // First try to load from secure storage
      jsonString =
          await secureStorage.read(key: 'locale_${locale.languageCode}');

      if (jsonString != null) {
        final localizedMap = json.decode(jsonString) as Map<String, dynamic>;
        // Remove metadata
        localizedMap.remove('@@locale');

        localizedStrings = localizedMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
        debugPrint(
            'Loaded ${localizedStrings.length} translations from secure storage');
      } else {
        debugPrint('No translations found in secure storage');
      }
    } catch (e) {
      debugPrint('Error loading from secure storage: $e');
    }

    // If no translations were loaded from secure storage, try to load from assets
    if (localizedStrings.isEmpty) {
      try {
        // Try from assets directory
        jsonString = await rootBundle
            .loadString('assets/l10n/app_${locale.languageCode}.arb');
        final localizedMap = json.decode(jsonString) as Map<String, dynamic>;
        localizedMap.remove('@@locale');

        localizedStrings = localizedMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );

        // Save to secure storage for future use
        await secureStorage.write(
          key: 'locale_${locale.languageCode}',
          value: jsonString,
        );

        debugPrint(
            'Loaded ${localizedStrings.length} translations from assets');
      } catch (e) {
        debugPrint('Error loading from assets: $e');

        // Last resort, try from lib directory
        try {
          jsonString = await rootBundle
              .loadString('lib/l10n/arb/app_${locale.languageCode}.arb');
          final localizedMap = json.decode(jsonString) as Map<String, dynamic>;
          localizedMap.remove('@@locale');

          localizedStrings = localizedMap.map(
            (key, value) => MapEntry(key, value.toString()),
          );

          debugPrint(
              'Loaded ${localizedStrings.length} translations from lib directory');
        } catch (e) {
          debugPrint('Failed to load translations from lib directory: $e');
        }
      }
    }

    return AppLocalizations(localizedStrings);
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}
