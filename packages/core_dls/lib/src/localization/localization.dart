import 'package:flutter/material.dart';
import 'package:core_dls/src/l10n/dls_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
