import 'package:flutter/material.dart';

mixin AppBoxDecorations {
  BoxDecoration roundedCornersDecoration({
    Color? borderColor,
    required Color fillColor,
    required double cornerRadius,
    double? borderWidth,
  }) =>
      BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1,
        ),
        borderRadius: BorderRadius.circular(cornerRadius),
      );

  BoxDecoration roundedCornersDecorationWithShadow({
    required Color borderColor,
    required Color fillColor,
    required double cornerRadius,
    required Color shadowColor,
    required double blurRadius,
    required double spreadRadius,
    required Offset shadowOffset,
  }) =>
      BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(cornerRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
            offset: shadowOffset,
          )
        ],
      );

  BoxDecoration topCornersDecoration({
    required Color borderColor,
    required Color fillColor,
    required double cornerRadius,
  }) =>
      BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        ),
      );
}
