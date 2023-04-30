import 'color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData darkPurpleTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  scaffoldBackgroundColor: darkpurple,
  splashColor: nicepurple,
  highlightColor: nicepink,
  textTheme: GoogleFonts.openSansTextTheme(
    TextTheme(
      titleSmall: GoogleFonts.openSans(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.openSans(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: GoogleFonts.openSans(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      labelSmall: GoogleFonts.openSans(color: Colors.white, fontSize: 15),
      labelLarge: GoogleFonts.openSans(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),
  focusColor: nicepink,

  // fontFamily: GoogleFonts.openSans().fontFamily,
);
