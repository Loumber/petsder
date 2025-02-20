part of 'theme.dart';

ThemeData materialThemeFromAppTheme(AppThemeData theme, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: theme.main.scaffoldBackgroundColor,
  );
} 

CupertinoThemeData cupertinoThemeFromAppTheme(AppThemeData theme, Brightness brightness) =>
    MaterialBasedCupertinoThemeData(materialTheme: materialThemeFromAppTheme(theme, brightness)).copyWith(
      scaffoldBackgroundColor: theme.main.scaffoldBackgroundColor,
    );

class AppThemeData {
  AppThemeData({
    required this.main,
    required this.isDarkMode,
  });

  factory AppThemeData.dark() => AppThemeData(
        main: MainColors.dark(),
        isDarkMode: true,
      );

  factory AppThemeData.light() => AppThemeData(
        main: MainColors.light(),
        isDarkMode: false,
      );

  final bool isDarkMode;

  final MainColors main;
}