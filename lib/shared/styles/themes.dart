import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        fontFamily: 'jannah',
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: HexColor('333739'),
    ),
    textTheme: const TextTheme(
      titleLarge : TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium : TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: Colors.white,
      ),
    ),

    fontFamily: 'Jannah'
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
      fontFamily: 'jannah',
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
titleLarge : TextStyle(
fontSize: 25.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
),
    titleMedium : TextStyle(
fontSize: 18.0,
fontWeight: FontWeight.bold,
color: Colors.black,
),
titleSmall: TextStyle(
fontSize: 14.0,
height: 1.3,
fontWeight: FontWeight.bold,
color: Colors.black,
),
),
  fontFamily: 'jannah',
);