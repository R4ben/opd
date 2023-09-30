import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 239, 255, 239),
    colorScheme: const ColorScheme(
      primary: Color.fromARGB(255, 106, 151, 36),
      secondary: Color.fromARGB(255, 143, 150, 253),
      background: Color.fromARGB(255, 239, 255, 239),
      surface: Color.fromARGB(255, 235, 235, 235),
      error: Color.fromARGB(255, 255, 68, 68),
      brightness: Brightness.light,
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onError: Color(0xFF2b2e4a),
      onBackground: Color(0xFF2b2e4a),
      onSurface: Color(0xFF2b2e4a),
    ),
    fontFamily: 'Futura',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 28,
      ),
      displaySmall: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headlineLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headlineMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineSmall: TextStyle(
        color: Color.fromARGB(255, 35, 40, 83),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
          color: Color(0xFF2b2e4a),
          fontWeight: FontWeight.normal,
          fontSize: 24,
          height: 1.3),
      bodyMedium: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        color: Color(0xFF2b2e4a),
        fontWeight: FontWeight.normal,
        fontSize: 13,
      ),
    ),
  );
}
