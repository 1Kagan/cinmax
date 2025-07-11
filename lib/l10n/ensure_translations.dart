import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// This class ensures translations are available at runtime
/// by copying ARB files to the correct location and registering them
/// with FlutterSecureStorage
class EnsureTranslations {
  /// Ensure translations are loaded and available
  static Future<bool> ensureTranslationsAvailable() async {
    try {
      // 1. Create asset directory if it doesn't exist
      final assetDir = Directory('assets/l10n');
      if (!await assetDir.exists()) {
        await assetDir.create(recursive: true);
      }

      // 2. Copy the ARB files to assets directory
      await _copyArbFiles();

      // 3. Register translations with secure storage
      await _registerTranslations();

      return true;
    } catch (e) {
      debugPrint('Error ensuring translations are available: $e');
      return false;
    }
  }

  /// Copy ARB files from lib to assets directory
  static Future<void> _copyArbFiles() async {
    // Get the list of ARB files
    final directory = Directory('lib/l10n/arb');
    if (!await directory.exists()) {
      debugPrint('ARB directory does not exist');
      return;
    }

    final arbFiles = await directory
        .list()
        .where((entity) => entity.path.endsWith('.arb'))
        .toList();

    // Copy each file to assets directory
    for (final file in arbFiles) {
      final fileName = file.path.split('/').last;
      final targetPath = 'assets/l10n/$fileName';

      final sourceFile = File(file.path);

      await sourceFile.copy(targetPath);
      debugPrint('Copied ${file.path} to $targetPath');
    }
  }

  /// Register translations with secure storage
  static Future<void> _registerTranslations() async {
    const secureStorage = FlutterSecureStorage();

    // Load and register English translations
    try {
      final enFile = File('assets/l10n/app_en.arb');
      if (await enFile.exists()) {
        final content = await enFile.readAsString();
        await secureStorage.write(key: 'locale_en', value: content);
        debugPrint('Registered English translations');
      }
    } catch (e) {
      debugPrint('Failed to register English translations: $e');
    }

    // Load and register Turkish translations
    try {
      final trFile = File('assets/l10n/app_tr.arb');
      if (await trFile.exists()) {
        final content = await trFile.readAsString();
        await secureStorage.write(key: 'locale_tr', value: content);
        debugPrint('Registered Turkish translations');
      }
    } catch (e) {
      debugPrint('Failed to register Turkish translations: $e');
    }
  }
}
