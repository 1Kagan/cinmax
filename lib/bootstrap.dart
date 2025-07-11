import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/l10n/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_base/src/core/constants/string_constants.dart';
import 'package:flutter_base/src/injector.dart' as di;

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await _initialize();

  runApp(await builder());
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(logPrinter: const PrettyDeveloperPrinter());
  Bloc.observer = const AppBlocObserver();

  di.init();

  try {
    await AppLocalizations.initializeTranslations();
    debugPrint('Translations initialized from ARB files');
  } catch (e) {
    debugPrint('Error initializing translations: $e');
  }

  final directory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: directory,
  );

  try {
    await dotenv.load(fileName: '.env.${StringContants.environment}');
  } catch (e) {
    debugPrint(
        'Warning: Environment file not found or empty. Continuing without it.');
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
