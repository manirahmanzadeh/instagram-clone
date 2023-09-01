import 'package:flutter/material.dart';

mixin FinstagramTheme {
  static ThemeData get light => ThemeData(
        fontFamily: 'proxima',
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFFDD2A7B),
        // Instagram's primary color
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF12C186), // Instagram's highlight color
          unselectedItemColor: Color(0xFF9B9B9B), // Instagram's secondary color
          showUnselectedLabels: true,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF474747),
          ),
          bodyLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF474747),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF474747),
          ),
          bodySmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9F9F9F),
          ),
          // Add more text styles as needed
        ),
      );
}
