part of 'theme.dart';

ThemeData materialThemeFromAppTheme(AppThemeData theme, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    /*colorScheme: ColorScheme(
        brightness: brightness,
        primary: theme.main.primary,
        onPrimary: theme.main.onPrimary,
        secondary: theme.main.secondary,
        onSecondary: theme.main.onSecondary,
        error: theme.main.error,
        onError: theme.main.onPrimary,
        surface: theme.main.background,
        onSurface: theme.main.onBackground,
      ),*/
    scaffoldBackgroundColor: theme.main.scaffoldBackgroundColor,
    appBarTheme: AppBarTheme(
        centerTitle: true,
        //titleTextStyle: theme.textTheme.headlineMedium,
        //actionsIconTheme: IconThemeData(color: theme.main.onBackground),
        //iconTheme: IconThemeData(color: theme.main.onBackground),
        elevation: 4,
        //foregroundColor: Colors.white,
        backgroundColor: theme.main.appBarBackgroundColor,
        //surfaceTintColor: theme.main.background,
        //shadowColor: theme.main.futter.withOpacity(0.5),
      ),
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