import 'color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkPurpleTheme = ThemeData(
  useMaterial3: true,

  brightness: Brightness.dark,

  appBarTheme: const AppBarTheme(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white),

  scaffoldBackgroundColor: darkpurple,
  splashColor: nicepurple.withOpacity(0.5),
  highlightColor: nicepink.withOpacity(0.5),
  textTheme: GoogleFonts.openSansTextTheme(
    TextTheme(
      displayMedium: GoogleFonts.openSans(
          color: Colors.white, fontSize: 19, fontWeight: FontWeight.w600),
      displaySmall: GoogleFonts.openSans(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.openSans(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.openSans(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.openSans(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      labelSmall: GoogleFonts.openSans(color: Colors.white, fontSize: 15),
      labelLarge: GoogleFonts.openSans(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
      bodySmall: GoogleFonts.openSans(
          color: Colors.white, fontSize: 11, fontWeight: FontWeight.w400),
      bodyMedium: GoogleFonts.openSans(
          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
    ),
  ),
  focusColor: nicepink,

  // fontFamily: GoogleFonts.openSans().fontFamily,
);
