import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  //static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _lightAppbarColor = Colors.blue;
  
  static const TextStyle _lightHeadingTheme = TextStyle(color: _lightTextColorPrimary, fontFamily: 'Rubik', fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle _lightBodyTheme =  TextStyle(color: _lightTextColorPrimary, fontFamily: 'Rubik', fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 16);
  
  static final Color _darkPrimaryColor = Colors.blueGrey.shade900;
 // static final Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _darkAppbarColor = Colors.blueGrey.shade800;

  static final TextStyle _darkHeadingTheme = _lightHeadingTheme.copyWith(color: _darkTextColorPrimary);
  static final TextStyle _darkBodyTheme = _lightBodyTheme.copyWith(color: _darkTextColorPrimary);

  static const Color _iconColor = Colors.white;

  static const Color _accentColorLight = Color.fromRGBO(74, 217, 217, 1);
  static const Color _accentColordark = Color.fromRGBO(74, 217, 217, 1);

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge : _lightHeadingTheme,
    bodyLarge : _lightBodyTheme,
  );

    static final TextTheme _darkTextTheme =TextTheme(
    displayLarge : _darkHeadingTheme,
    bodyLarge : _darkBodyTheme,
  );

  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: const AppBarTheme(
          color: _lightAppbarColor,
          iconTheme: IconThemeData(color: _iconColor)),
      colorScheme: ColorScheme.light(
        primary: _lightPrimaryColor,
        onPrimary: _lightOnPrimaryColor,
        secondary: _accentColorLight,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: _lightAppbarColor),
      textTheme: _lightTextTheme);

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryColor,
      appBarTheme: AppBarTheme(
          color: _darkAppbarColor, iconTheme: const IconThemeData(color: _iconColor)),
      colorScheme: ColorScheme.dark(
        primary: _darkPrimaryColor,
        onPrimary: _darkOnPrimaryColor,
        secondary: _accentColordark,
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: _darkAppbarColor),
            textTheme: _darkTextTheme);
}
