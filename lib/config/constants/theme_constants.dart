import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeConstants {
  static ThemeData lightThemeAndroid = ThemeData(
    fontFamily: 'Oxygen',
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
    ),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.grey.shade900),
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    focusColor: Colors.amber,
    splashColor: Colors.grey.shade900,
    accentColor: Colors.white,
    canvasColor: Colors.grey.shade900,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    textTheme: TextTheme(overline: TextStyle(color: Colors.amber)),
  );
}
