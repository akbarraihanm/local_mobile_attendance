import 'package:flutter/material.dart';

class AppTypography {
  static TextStyle display({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 34,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle title1({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle title2({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle title3({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle title4({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle subTitle1({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle subTitle2({Color? color, FontStyle? style}) => TextStyle(
    color: color ?? Colors.black,
    fontWeight: FontWeight.w600,
    fontStyle: style ?? FontStyle.normal,
  );

  static TextStyle body1({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 16,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle body2({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle action1({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle action2({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontWeight: FontWeight.w600,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle action3({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 12,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle action4({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 10,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle caption1({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 12,
      fontStyle: style ?? FontStyle.normal
  );

  static TextStyle caption2({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 10,
      fontStyle: style ?? FontStyle.normal
  );
  static TextStyle small({Color? color, FontStyle? style}) => TextStyle(
      color: color ?? Colors.black,
      fontSize: 8,
      fontStyle: style ?? FontStyle.normal
  );
}