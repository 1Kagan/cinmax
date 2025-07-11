import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_base/src/core/constants/secure_storage_keys.dart';
import 'package:flutter_base/src/core/enums/enums.dart';

final class SecureStorage {
  SecureStorage(this.storage);
  final FlutterSecureStorage storage;

  Future<void> initLocalization() async {
    try {
      final locale = await getLocale();

      if (locale != null) {
        await setLocale(locale: Locale(locale));
      } else {
        await setLocale(locale: Locale(LocaleEnums.english.value.toString()));
      }
    } catch (e) {
      logInfo('Error while setting locale to English: $e');
      await setLocale(locale: Locale(LocaleEnums.english.value.toString()));
    }
  }

  Future<void> setLocale({required Locale locale}) async {
    try {
      await storage.write(
        key: SecureStorageKeys.locale,
        value: locale.languageCode,
      );
      logInfo('Locale is set to $locale');
    } catch (e) {
      logInfo('Error while setting locale to $locale: $e');
    }
  }

  Future<String?> getLocale() async {
    try {
      return await storage.read(key: SecureStorageKeys.locale);
    } catch (e) {
      logInfo('Error while getting locale: $e');
      return null;
    }
  }

  Future<void> removeKey({required String key}) async {
    logInfo('$key is removed');
    await storage.delete(key: key);
  }

  Future<void> clearAll() async {
    logInfo('Storage is cleared');
    await storage.deleteAll();
  }
}