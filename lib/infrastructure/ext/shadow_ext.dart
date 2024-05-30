import 'package:flutter/material.dart';

extension BoxShadowExtension on BoxShadow {
  // Named constructor for a light shadow
  static BoxShadow light({
    Color color = Colors.black12,
    double blurRadius = 1,
    Offset offset = Offset.zero,
    double spreadRadius = 0,
  }) {
    return BoxShadow(
      color: color,
      blurRadius: blurRadius,
      offset: offset,
      spreadRadius: spreadRadius,
    );
  }

  // Named constructor for a medium shadow
  static BoxShadow medium({
    Color color = Colors.black12,
    double blurRadius = 4,
    Offset offset = Offset.zero,
    double spreadRadius = 0,
  }) {
    return BoxShadow(
      color: color,
      blurRadius: blurRadius,
      offset: offset,
      spreadRadius: spreadRadius,
    );
  }

  // Named constructor for a heavy shadow
  static BoxShadow heavy({
    Color color = Colors.black12,
    double blurRadius = 6,
    Offset offset = Offset.zero,
    double spreadRadius = 0,
  }) {
    return BoxShadow(
      color: color,
      blurRadius: blurRadius,
      offset: offset,
      spreadRadius: spreadRadius,
    );
  }
}
