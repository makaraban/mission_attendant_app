import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(){
  final fgColor = Colors.black;
  final bgColor = Colors.white;
  final bg2Color = Colors.white;
  return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        titleSmall: GoogleFonts.battambang(fontSize: 16),
        titleMedium: GoogleFonts.battambang(fontSize: 20),
        titleLarge: GoogleFonts.battambang(fontSize: 24),
        bodyMedium: GoogleFonts.battambang(fontSize: 18),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.battambang(fontSize: 18, color: Colors.black),
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.grey.shade100,
        elevation: 1,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedItemColor: fgColor,
      )
  );
}