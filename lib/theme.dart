import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeLight() {
  final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.oswaldTextTheme(),
    appBarTheme: ThemeData.from(colorScheme: colorScheme).appBarTheme.copyWith(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.background,
      centerTitle: true,
    ),
  );
}