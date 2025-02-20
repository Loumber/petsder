import 'package:l/l.dart';

class AppLogger {
  static void warning(Object msg, [StackTrace? stackTrace]) {
    const AnsiColor ansiColor = AnsiColor.fg(214);

    l.w(
      '''${ansiColor('Warning')}
${ansiColor(msg.toString())}''',
      stackTrace,
    );
  }

  static void success(
    Object msg,
  ) {
    const AnsiColor ansiColor = AnsiColor.fg(46);

    l.i(
      '''${ansiColor('Success')}
${ansiColor(msg.toString())}''',
    );
  }

  static void error(Object msg, [StackTrace? stackTrace]) {
    const AnsiColor ansiColor = AnsiColor.fg(196);

    l.e(
      '''${ansiColor('Error')}
${ansiColor(msg.toString())}''',
      stackTrace,
    );

    // if (stackTrace != null) {
    //   unawaited(_createLog('$msg stackTrace: $stackTrace'));
    // } else {
    //   unawaited(_createLog('$msg'));
    // }
  }


  static void info(Object msg, [StackTrace? stackTrace]) {
    const AnsiColor ansiColor = AnsiColor.fg(45);
    l.v1('''${ansiColor('Info')}
${ansiColor(msg.toString())}
''');
  }
}

/// Color console messages
class AnsiColor {
  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  final int? fg;
  final int? bg;
  final bool color;

  const AnsiColor.none()
      : fg = null,
        bg = null,
        color = false;

  const AnsiColor.fg(this.fg)
      : bg = null,
        color = true;

  const AnsiColor.bg(this.bg)
      : fg = null,
        color = true;

  @override
  String toString() {
    if (fg != null) {
      return '${ansiEsc}38;5;${fg}m';
    } else if (bg != null) {
      return '${ansiEsc}48;5;${bg}m';
    } else {
      return '';
    }
  }

  String call(String msg) {
    if (color) {
      // ignore: unnecessary_brace_in_string_interps
      return '${this}$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  AnsiColor toFg() => AnsiColor.fg(bg);

  AnsiColor toBg() => AnsiColor.bg(fg);

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => color ? '${ansiEsc}39m' : '';

  /// Defaults the terminal's background color without altering the foreground.
  String get resetBackground => color ? '${ansiEsc}49m' : '';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
}
