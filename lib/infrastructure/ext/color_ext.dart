import 'package:flutter/material.dart';

extension ColorSchemeGradient on ColorScheme {
  LinearGradient get primaryToSecondaryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          onSurface,
          primary, // Warna primer dari ColorScheme
          secondary, // Warna sekunder dari ColorScheme
        ],
      );

  LinearGradient get secondaryTotertieryGradient => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          secondary, // Accent Color: Orange
          tertiary,
        ],
      );
}
