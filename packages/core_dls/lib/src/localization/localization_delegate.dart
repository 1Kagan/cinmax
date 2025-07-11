import 'package:flutter/material.dart';
import 'package:core_dls/src/l10n/dls_localizations.dart';

class BaseDlsAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const BaseDlsAppLocalizationsDelegate();

  static late AppLocalizations instance;

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.delegate.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final instance = await AppLocalizations.delegate.load(locale);
    BaseDlsAppLocalizationsDelegate.instance = instance;
    return instance;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
