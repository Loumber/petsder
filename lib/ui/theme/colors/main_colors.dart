part of '../theme.dart';

class MainColors {

  MainColors({
    required this.scaffoldBackgroundColor,
  });

  factory MainColors.light() => MainColors(
    scaffoldBackgroundColor: Colors.white,
  );

  factory MainColors.dark() => MainColors(
    scaffoldBackgroundColor: Colors.black,
  );

  Color scaffoldBackgroundColor;
}