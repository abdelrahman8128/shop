// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p4all/shared/styles/colors.dart';

ThemeData darkTheme=ThemeData(
 colorScheme: ColorScheme.dark(primary: Colors.deepOrange),

  fontFamily: 'Janna',
  scaffoldBackgroundColor: Colors.grey[850],
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey[850],
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.grey[850],
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    backgroundColor: Colors.grey[850],
    selectedItemColor: defaultColor,
    //unselectedItemColor: ,
  ),
  textTheme: TextTheme(
    
    bodyMedium: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),

  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(defaultColor)),
  ),

);
ThemeData lightTheme=ThemeData(

colorScheme:ColorScheme.light(primary: Colors.deepOrange),


  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(defaultColor)),
  ),
  fontFamily: 'Janna',
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white70,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),



);