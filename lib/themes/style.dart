import 'package:flutter/material.dart';


 final textColor = Colors.black;
 final iconsColor = const Color.fromRGBO(20, 30, 39, 1);
 final primaryColor = Color.fromRGBO(165, 117, 255, 1);
 final secondaryColor = Colors.blue;
 final backGroundColor = const Color.fromRGBO(255, 247, 238, 1);
 final white = const Color.fromRGBO(255, 255, 255, 1);

/* Colors */
class MyThemes {

 final darkTheme = ThemeData(
  primaryColor:  Color.fromRGBO(165, 117, 255, 1),
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  iconTheme: const IconThemeData(color: Colors.white),
  listTileTheme: const ListTileThemeData(
   iconColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white) ),
 );

 final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor:  Color.fromRGBO(165, 117, 255, 1),
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  iconTheme: const IconThemeData(color: Colors.black54),
  listTileTheme: const ListTileThemeData(
   iconColor: Colors.black54,
  ),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black54),
  actionsIconTheme: IconThemeData(color: Colors.black54) ),
 );
}
