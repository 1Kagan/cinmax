import 'package:example/icons_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:core_dls/core_dls.dart';

import 'components/components_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) => MaterialApp(
        title: 'DLS Catalog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainNodeLayout(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        children: [
          _pushButton(
            'Components',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ComponentsScreen(),
              ),
            ),
          ),
          _pushButton(
            'Icons',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const IconsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pushButton(
    String label,
    VoidCallback onTap,
  ) =>
      LinkListTile(
        title: label,
        onTap: onTap,
      );
}
