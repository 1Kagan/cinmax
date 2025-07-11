import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData light = ThemeData(
    useMaterial3: true,
    cardColor: AppColorTheme.customGray,
    scaffoldBackgroundColor: AppColorTheme.white,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    iconTheme: const IconThemeData(color: AppColorTheme.pureBlack),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorTheme.inputBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      labelStyle: const TextStyle(color: AppColorTheme.pureBlack),
      hintStyle: TextStyle(color: Colors.grey[600]),
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: AppColorTheme.white,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
    ),
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension.light,
    ],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorTheme.orange,
      brightness: Brightness.light,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColorTheme.orange;
        }
        return AppColorTheme.gray;
      }),
    ),
  );

  ThemeData dark = ThemeData(
    useMaterial3: true,
    cardColor: AppColorTheme.cardColorDark,
    scaffoldBackgroundColor: const Color(0xFF090909),
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    iconTheme: const IconThemeData(color: AppColorTheme.pureWhite),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorTheme.inputDarkBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      labelStyle: const TextStyle(color: AppColorTheme.pureWhite),
      hintStyle: TextStyle(color: Colors.grey[400]),
    ),
    drawerTheme: const DrawerThemeData(
      elevation: 0,
      backgroundColor: AppColorTheme.pureBlack,
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.transparent,
    ),
    extensions: <ThemeExtension<dynamic>>[
      CustomThemeExtension.dark,
    ],
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColorTheme.darkBg,
      brightness: Brightness.dark,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColorTheme.white;
        }
        return AppColorTheme.gray;
      }),
    ),
  );
}

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  CustomThemeExtension({
    required this.logoPath,
    required this.drawerHeaderColor,
    required this.drawerBodyColor,
    required this.drawerHeaderTextColor,
  });

  final String logoPath;
  final Color drawerHeaderColor;
  final Color drawerBodyColor;
  final Color drawerHeaderTextColor;

  static final light = CustomThemeExtension(
    logoPath: 'assets/images/logo.png',
    drawerHeaderColor: AppColorTheme.orange,
    drawerBodyColor: AppColorTheme.white,
    drawerHeaderTextColor: AppColorTheme.pureWhite,
  );

  static final dark = CustomThemeExtension(
    logoPath: 'assets/images/logo_black_theme.png',
    drawerHeaderColor: AppColorTheme.darkBg,
    drawerBodyColor: AppColorTheme.pureBlack,
    drawerHeaderTextColor: AppColorTheme.pureWhite,
  );

  @override
  CustomThemeExtension copyWith({
    String? logoPath,
    Color? drawerHeaderColor,
    Color? drawerBodyColor,
    Color? drawerHeaderTextColor,
  }) {
    return CustomThemeExtension(
      logoPath: logoPath ?? this.logoPath,
      drawerHeaderColor: drawerHeaderColor ?? this.drawerHeaderColor,
      drawerBodyColor: drawerBodyColor ?? this.drawerBodyColor,
      drawerHeaderTextColor:
          drawerHeaderTextColor ?? this.drawerHeaderTextColor,
    );
  }

  @override
  CustomThemeExtension lerp(
    ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      logoPath: logoPath,
      drawerHeaderColor:
          Color.lerp(drawerHeaderColor, other.drawerHeaderColor, t)!,
      drawerBodyColor: Color.lerp(drawerBodyColor, other.drawerBodyColor, t)!,
      drawerHeaderTextColor:
          Color.lerp(drawerHeaderTextColor, other.drawerHeaderTextColor, t)!,
    );
  }
}
