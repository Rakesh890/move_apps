import 'package:flutter/material.dart';

TextTheme buildTextTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700,color: Colors.white),
    headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600,color: Colors.white),
    headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500,color: Colors.white),
  );
}
