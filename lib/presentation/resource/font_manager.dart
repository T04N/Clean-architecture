import 'package:flutter/material.dart';

class FontConstants {
  static const String fontFamily = "Montserrat";
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
}
TextStyle getSemiBoldStyle({required Color color, double fontSize = FontSize.s16}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w600, // Semi-bold weight
  );
}

TextStyle getMediumStyle({required Color color, double fontSize = FontSize.s14}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w500, // Medium weight
  );
}

TextStyle getRegularStyle({required Color color, double fontSize = FontSize.s12}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w400, // Regular weight
  );
}

TextStyle getBoldStyle({required Color color, double fontSize = FontSize.s18}) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: FontWeight.w700, // Bold weight
  );
}
