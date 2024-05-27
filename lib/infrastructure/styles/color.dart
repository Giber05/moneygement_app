import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';

// Updated Primary Color
const _primaryColor = Color(0xFF5E72EB); // Blue

// Since ColorScheme.fromSeed might not perfectly align with the secondary and accent recommendations,
// we manually adjust the color scheme below as much as the API allows.
const _lightScheme = ColorScheme.light(
  primary: _primaryColor,
  secondary: Color(0xFFFF9190), // Green as secondary
  surface: Color(0xFFFFFFFF), // Light grey for surfaces
  background: Color(0xFFF9f9F9), // Light grey for backgrounds
  onPrimary: Color(0xFFFFFFFF), // White text/icons on primary color for contrast
  onSecondary: Color(0xFFFFFFFF), // White text/icons on secondary color for contrast
  error: Color(0xFFB00020), // Default error, adjust as necessary
  onError: Color(0xFFFFFFFF), // White text/icons on error color for contrast
  onSurface: Color(0xFF120c6e), // Dark grey for text/icons on surface
  onBackground: Color(0xFF212121), // Dark grey for text/icons on background
  brightness: Brightness.light,
  tertiary: Color(0xFFFDC094), // Lighter shade of Accent for Gradient
  onTertiary: Color(0xFFFFFFFF),
  surfaceTint: Colors.grey,
);

final _palette = CorePalette.of(_primaryColor.value);

class CBTheme {
  static Color get primaryColor => _primaryColor;
  static ColorScheme get lightScheme => _lightScheme;
  static CorePalette get palette => _palette;
}
