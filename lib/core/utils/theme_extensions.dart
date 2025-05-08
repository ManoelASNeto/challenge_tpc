import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextStyle get titleStyle => TextStyle(
        fontSize: 25,
        fontFamily: 'PlaywriteDanmarkLoopet',
        fontWeight: FontWeight.bold,
      );
  TextStyle get subtitleTextStyle => TextStyle(
        fontSize: 20,
        fontFamily: 'PlaywriteDanmarkLoopet',
      );
}
