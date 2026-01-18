import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme(){
  final fgColor = Colors.white;
  final bgColor = Colors.black;
  final bg2Color = Colors.indigo;
  return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        titleSmall: GoogleFonts.siemreap(fontSize: 16),
        titleMedium: GoogleFonts.siemreap(fontSize: 20),
        titleLarge: GoogleFonts.siemreap(fontSize: 24),
        bodyMedium: GoogleFonts.siemreap(fontSize: 18),
      ),
      appBarTheme: AppBarTheme(
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

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedItemColor: fgColor,
      )
  );
}