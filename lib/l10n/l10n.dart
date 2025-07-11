import 'package:flutter/widgets.dart';

import 'package:flutter_base/l10n/localization/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    return localizations;
  }
}
