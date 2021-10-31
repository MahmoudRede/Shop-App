import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Shared/Style/styles.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  iconTheme: IconThemeData(
    color: Colors.blue
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.grey[200],
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: defaultColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 28.0,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 20.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    headline1: defaultTextStyleLight,
    ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: darkColorBackground,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: darkColorBackground,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: defaultColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    titleSpacing: 20.0,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 28.0,
    ),

  ),
  scaffoldBackgroundColor: darkColorBackground,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorBackground,
    elevation: 20.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
  textTheme: TextTheme(
    headline1: defaultTextStyleDark,
  ),
);