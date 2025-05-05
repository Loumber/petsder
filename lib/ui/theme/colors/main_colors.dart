part of '../theme.dart';

class MainColors {

  MainColors({
    required this.scaffoldBackgroundColor,
    required this.appBarBackgroundColor,
    required this.primary,
    required this.onPrimary,
    required this.messageName,
    required this.divider,
    required this.googleButton,
    required this.inputFieldBackgroundColor,
    required this.inputFieldLabelColor,
    required this.inputFieldBorderColor,
    required this.error,
  });

  factory MainColors.light() => MainColors(
    scaffoldBackgroundColor: const Color(0xFFE7E7E7), 
    appBarBackgroundColor:  const Color(0xFFFF942E),
    primary:  const Color(0xFFFF942E),
    onPrimary: Colors.white,
    googleButton: Colors.white,
    divider: const Color(0xFFEAEBED),
    inputFieldBackgroundColor: Colors.white,
    inputFieldLabelColor: const Color(0xFF919191),
    inputFieldBorderColor: const Color(0xFF919191),
    messageName: Colors.black,
    error: const Color(0xFFFF0000),
  );

  factory MainColors.dark() => MainColors(
    scaffoldBackgroundColor:  Colors.black,
    messageName: Colors.white,
    appBarBackgroundColor:  const Color(0xFFFF942E),
    primary:  const Color(0xFFFF942E),
    divider: const Color(0xFF2F374E),
    onPrimary: Colors.white,
    googleButton: const Color(0xFF121111),
    inputFieldBackgroundColor: const Color(0xFF121111),
    inputFieldLabelColor:  const Color(0xFFD2D2D7),
    inputFieldBorderColor: const Color(0xFFD2D2D7),
    error: const Color(0xFFFF0000),
  );

  Color scaffoldBackgroundColor;
  Color messageName;
  Color appBarBackgroundColor;
  Color primary;
  Color onPrimary;
  Color divider;
  Color googleButton;
  Color inputFieldBackgroundColor;
  Color inputFieldLabelColor;
  Color inputFieldBorderColor;
  Color error;
}