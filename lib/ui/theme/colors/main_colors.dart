part of '../theme.dart';

class MainColors {

  MainColors({
    required this.scaffoldBackgroundColor,
    required this.appBarBackgroundColor,
    required this.primary,
    required this.onPrimary,
  });

  factory MainColors.light() => MainColors(
    scaffoldBackgroundColor: Colors.white,
    appBarBackgroundColor: Colors.amber,
    primary: Colors.amber,
    onPrimary: Colors.white,
  );

  factory MainColors.dark() => MainColors(
    scaffoldBackgroundColor: Colors.black,
    appBarBackgroundColor: Colors.amber,
    primary: Colors.amber,
    onPrimary: Colors.white,
  );

  Color scaffoldBackgroundColor;
  Color appBarBackgroundColor;
  Color primary;
  Color onPrimary;
}