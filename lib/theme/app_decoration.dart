import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
// Outline decorations
  static BoxDecoration get outlineOnPrimaryContainer => BoxDecoration(
        color: appTheme.blueGray700,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onPrimaryContainer.withOpacity(0.1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      );
// Surface decorations
  static BoxDecoration get surface1 => BoxDecoration(
        color: appTheme.blueGray900,
      );
  static BoxDecoration get surface2 => BoxDecoration(
        color: appTheme.blueGray700,
      );
}

class BorderRadiusStyle {
  // Rounded borders
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}
