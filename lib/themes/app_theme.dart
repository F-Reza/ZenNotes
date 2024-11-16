import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2d38ff),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0d1393),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
  );
}
