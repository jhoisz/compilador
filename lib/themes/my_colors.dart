import 'package:flutter/material.dart';

class MyColorsDark extends MyColors {
  MyColorsDark()
      : super(
          const Color(0xFFD9487D),
          const Color(0xFF8736D9),
          const Color(0xFF0476D9),
          const Color(0xFF525AF2),
          const Color(0xFFF2955E),
          const Color(0xFF9784D9),
          const Color(0xFFE4EBF2),
          const Color(0xFF04D9C4),
          const Color(0xFF033859),
          const Color(0xFFF20544),
          const Color(0xFF24F205),
        );
}

class MyColorsLight extends MyColors {
  MyColorsLight()
      : super(
          const Color(0xFF858BF2),
          const Color(0xFF0433BF),
          const Color(0xFFD904B5),
          const Color(0xFF8736D9),
          const Color(0xFF3B7302),
          const Color(0xFF3B7302),
          const Color(0xFF4D5673),
          const Color(0xFF222CF2),
          const Color(0xFFCED3F2),
          const Color(0xFFD93232),
          const Color(0xFF078C03),
        );
}

abstract class MyColors {
  final Color variant1;
  final Color variant2;
  final Color variant3;
  final Color variant4;
  final Color variant5;
  final Color variant6;

  final Color normal;

  final Color secondaryColor;
  final Color background;
  final Color error;
  final Color success;

  MyColors(
    this.variant1,
    this.variant2,
    this.variant3,
    this.variant4,
    this.variant5,
    this.variant6,
    this.normal,
    this.secondaryColor,
    this.background,
    this.error,
    this.success,
  );
}
