
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF3883FB);
const backgroundLightColor = Color(0xFFFCFCFC);
const backgroundDarkColor = Color(0xFF1F2026);
const navigationBarLightColor = Colors.white;
const navigationBarDarkColor = Color(0xFF30313C);

class Themes {
  static final themeLight = ThemeData.light().copyWith(
    backgroundColor: backgroundLightColor,
    accentColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: navigationBarLightColor,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.red
    ),
    toggleableActiveColor: primaryColor,
    canvasColor: backgroundLightColor
  );

  static final themeDark = ThemeData.dark().copyWith(
    backgroundColor: backgroundDarkColor,
    accentColor: primaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: navigationBarDarkColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Color(0xFF6162CB)
    ),
    textSelectionColor: Colors.white,
    toggleableActiveColor: primaryColor,
    canvasColor: backgroundDarkColor
  );
}