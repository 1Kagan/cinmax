import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_base/src/core/cubit/app_theme/app_theme_constants.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState(themeMode: ThemeMode.dark)) {
    _loadTheme();
  }

  Future<void> toggleTheme() async {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(AppThemeState(themeMode: newThemeMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppThemeConstants.themePrefKey,
      newThemeMode.toString().split('.').last,
    );
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    emit(AppThemeState(themeMode: themeMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      AppThemeConstants.themePrefKey,
      themeMode.toString().split('.').last,
    );
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(AppThemeConstants.themePrefKey);
    if (themeString != null) {
      final themeMode = themeString == AppThemeConstants.dark
          ? ThemeMode.dark
          : ThemeMode.light;
      emit(AppThemeState(themeMode: themeMode));
    }
  }
}
