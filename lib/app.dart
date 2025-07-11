import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base/l10n/localization/app_localizations.dart';
import 'package:flutter_base/l10n/localization/app_localizations_delegate.dart';
import 'package:flutter_base/src/config/router/app_router.dart';
import 'package:flutter_base/src/core/cubit/app_language/app_language_cubit.dart';
import 'package:flutter_base/src/core/cubit/app_theme/app_theme_cubit.dart';
import 'package:flutter_base/src/core/theme/app_theme.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_bloc.dart';
import 'package:flutter_base/src/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_base/src/config/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = injector<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<AuthBloc>(),
        ),
        BlocProvider<AppLanguageCubit>(
          create: (_) => AppLanguageCubit(),
        ),
        BlocProvider(
          create: (_) => AppThemeCubit(),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            appRouter.replaceAll([const LoginRoute()]);
          }
        },
        child: BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<AppLanguageCubit, AppLanguageState>(
              builder: (context, state) {
                return ScreenUtilInit(
                  child: MaterialApp.router(
                    debugShowCheckedModeBanner: false,
                    routerConfig: appRouter.config(),
                    theme: injector<AppTheme>().light,
                    darkTheme: injector<AppTheme>().dark,
                    themeMode: themeState.themeMode,
                    locale: Locale(state.appLanguage.languageCode),
                    localizationsDelegates: const [
                      AppLocalizationsDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
