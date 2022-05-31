import 'package:flutter/material.dart';
export 'app_colors.dart';
export 'app_text_theme.dart';
export 'button_theme.dart';
export 'svg_constants.dart';
export 'validator_text.dart';

class ThemeConfig {
  static ThemeData createTheme({
    Brightness? brightness,
    Color? background,
  }) {
    return ThemeData(
      brightness: brightness,
      backgroundColor: background,
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: Colors.white,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: Colors.black,
      );
}
