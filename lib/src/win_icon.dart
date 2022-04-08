/// A type of icon image that ships with Windows per default.
///
/// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadicona
enum WinIcon {
  application,
  error,
  question,
  warning,
  information,
  shield,
}

extension IconCodes on WinIcon {
  /// The internal resource id used by Windows.
  int get code {
    switch (this) {
      case WinIcon.application:
        return 32512;
      case WinIcon.error:
        return 32513;
      case WinIcon.question:
        return 32514;
      case WinIcon.warning:
        return 32515;
      case WinIcon.information:
        return 32516;
      case WinIcon.shield:
        return 32518;
    }
  }

  /// Returns an emoji that looks similar to the actual [WinIcon].
  String get emoji {
    switch (this) {
      case WinIcon.application:
        return "📰";
      case WinIcon.error:
        return "❌";
      case WinIcon.question:
        return "❔";
      case WinIcon.warning:
        return "⚠️";
      case WinIcon.information:
        return "❕";
      case WinIcon.shield:
        return "🛡";
    }
  }
}
