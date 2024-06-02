import 'package:flutter/material.dart';

import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyLargeInterLightgreen50 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.lightGreen50.withOpacity(0.53),
      );

  static get bodyLargeInterPrimary => theme.textTheme.bodyLarge!.inter.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyLargeLightgreen50 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.lightGreen50.withOpacity(0.53),
      );

  static get bodyLargePrimary => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primary,
      );

  static get bodyLargeSFProTextPrimary =>
      theme.textTheme.bodyLarge!.sFProText.copyWith(
        color: theme.colorScheme.primary,
      );

// Headline text style
  static get headlineLargeGray200 => theme.textTheme.headlineLarge!.copyWith(
        color: appTheme.gray200,
      );

// Title text style
  static get titleMediumInter => theme.textTheme.titleMedium!.inter.copyWith(
        fontWeight: FontWeight.w600,
      );

  static get titleLargePrimary => theme.textTheme.titleLarge!.inter.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      );
}
