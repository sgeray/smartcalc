import 'package:flutter/material.dart';
import 'app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[100],
    inputDecorationTheme: AppStyles.input,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.primaryButton,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
    inputDecorationTheme: AppStyles.input,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.primaryButton,
    ),
  );
}
