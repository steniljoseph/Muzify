import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.black,
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
      backgroundColor: Colors.black,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    snackBarTheme: const SnackBarThemeData(backgroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.white,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colors.white,
      textStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.white,
      inactiveTickMarkColor: Colors.grey,
      thumbColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.black,
    ),
  );

  static final lightTheme = ThemeData(
    // appBarTheme: const AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarBrightness: Brightness.light,
    //     systemNavigationBarColor: Colors.white,
    //   ),
    //   titleTextStyle: TextStyle(
    //     color: Colors.black,
    //     fontWeight: FontWeight.w600,
    //     fontSize: 30,
    //   ),
    //   backgroundColor: Colors.white,
    //   elevation: 0.0,
    //   iconTheme: IconThemeData(color: Colors.black),
    // ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 30,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: Colors.white),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colors.black,
      textStyle: TextStyle(color: Colors.white),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: Colors.black,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
    ),
  );
}
