import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xFF0B0B0B);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color gold = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFE8C97A);
  static const Color goldDim = Color(0xFF7A6230);
  static const Color textPrimary = Color(0xFFF0E8D8);
  static const Color textMuted = Color(0xFF7A7060);

  static ThemeData get theme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: black,
        colorScheme: const ColorScheme.dark(
          primary: gold,
          surface: darkCard,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: black,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: gold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: gold),
        ),
      );
}
