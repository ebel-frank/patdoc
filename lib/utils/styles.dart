import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patdoc/utils/colors.dart';

class AppStyles {
  ///TextStyles
  static const FontWeight _lightWeight = FontWeight.w300;
  static const FontWeight _w500 = FontWeight.w500;

  // static const FontWeight _extraBoldWeight = FontWeight.w800;
  static const FontWeight _normalWeight = FontWeight.w400;
  static const FontWeight _boldWeight = FontWeight.w700;

  static TextStyle color4Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.textColor4,
      );

  static TextStyle color4W500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.textColor4,
      );

  static TextStyle color4Light(double fontSize) => _base(
        fontSize,
        _lightWeight,
        AppColors.textColor4,
      );

  static TextStyle color5Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.textColor5,
      );

  static TextStyle color4Bold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.textColor4,
      );

  static TextStyle color3Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.textColor3,
      );

  static TextStyle color2Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.textColor2,
      );

  static TextStyle color2w500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.textColor2,
      );

  static TextStyle whiteNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.whiteColor,
      );

  static TextStyle whiteW500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.whiteColor,
      );

  static TextStyle whiteBold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.whiteColor,
      );

  static TextStyle shade2Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.primaryShade2,
      );

  static TextStyle shade2Light(double fontSize) => _base(
        fontSize,
        _lightWeight,
        AppColors.primaryShade2,
      );

  static TextStyle color1Bold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.textColor1,
      );

  static TextStyle color1Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.textColor1,
      );

  static TextStyle color1Light(double fontSize) => _base(
        fontSize,
        _lightWeight,
        AppColors.textColor1,
      );

  static TextStyle color1W500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.textColor1,
      );

  static TextStyle blackBold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.blackColor,
      );

  static TextStyle blackNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.blackColor,
      );

  static TextStyle blackW500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.blackColor,
      );

  static TextStyle blueBold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.blackColor,
      );

  static TextStyle primaryBold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.primaryColor,
      );

  static TextStyle primaryNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.primaryColor,
      );

  static TextStyle accent500(double fontSize) => _base(
        fontSize,
        _w500,
        AppColors.accentColor,
      );

  static TextStyle secondaryBold(double fontSize) => _base(
        fontSize,
        _boldWeight,
        AppColors.secondaryColor,
      );

  static TextStyle secondaryNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.secondaryColor,
      );

  static TextStyle progressGreenNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.progressGreen,
      );

  static TextStyle progressGreen2Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.progressGreen2,
      );

  static TextStyle progressRedNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.progressRed,
      );

  static TextStyle progressYellowNormal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.progressYellow,
      );

  static TextStyle progressShade2Normal(double fontSize) => _base(
        fontSize,
        _normalWeight,
        AppColors.progressShade2,
      );

  //#base style
  static TextStyle _base(
    double size,
    FontWeight? fontWeight,
    Color? color,
  ) {
    return baseStyle(fontSize: size, fontWeight: fontWeight, color: color);
  }

  static TextStyle baseStyle({
    double fontSize = 10,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return GoogleFonts.dmSans(
      fontSize: fontSize,
      fontWeight: fontWeight ?? _normalWeight,
      color: color ?? AppColors.textColor4,
    );
  }
}
