import 'package:flutter/material.dart';
import 'package:restaurants_app/style/colors/restaurants_colors.dart';
import 'package:restaurants_app/style/typoghraphy/restaurants_text_style.dart';

class RestaurantsTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantsColors.teal.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestaurantsColors.teal.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantsTextStyle.displayLarge,
      displayMedium: RestaurantsTextStyle.displayMedium,
      displaySmall: RestaurantsTextStyle.displaySmall,
      headlineLarge: RestaurantsTextStyle.headlineLarge,
      headlineMedium: RestaurantsTextStyle.headlineMedium,
      headlineSmall: RestaurantsTextStyle.headlineSmall,
      titleLarge: RestaurantsTextStyle.titleLarge,
      titleMedium: RestaurantsTextStyle.titleMedium,
      titleSmall: RestaurantsTextStyle.titleSmall,
      bodyLarge: RestaurantsTextStyle.bodyLarge,
      bodyMedium: RestaurantsTextStyle.bodyMedium,
      bodySmall: RestaurantsTextStyle.bodySmall,
      labelLarge: RestaurantsTextStyle.labelLarge,
      labelMedium: RestaurantsTextStyle.labelMedium,
      labelSmall: RestaurantsTextStyle.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        )
      ),
    );
  }
}