part of 'app_theme_cubit.dart';

class AppThemeState extends Equatable {

  const AppThemeState({required this.themeMode});
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}