import 'package:flutter/material.dart';
import 'package:nvvm/presentation/resource/value_manager.dart';
import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkGrey,
    disabledColor: ColorManager.grey, // will be used in case of disabled button for example
    hintColor: ColorManager.grey,
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryOpacity70,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Colors.white), // Corrected textStyle
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16), // Replaces headline1
      titleMedium: getMediumStyle(color: ColorManager.lightGrey, fontSize: FontSize.s14),    // Replaces subtitle1
      bodySmall: getRegularStyle(color: ColorManager.grey),                                 // Replaces caption
      bodyLarge: getRegularStyle(color: ColorManager.grey),                                  // Replaces bodyText1
    ),



  );
}
