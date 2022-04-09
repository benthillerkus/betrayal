/// A type of icon image that ships with Windows per default.
///
/// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadicona
enum WinIcon {
  /// 📰 An icon that looks similar to a program GUI
  application,
  /// ❌ A red circle with a white cross inside
  error,
  /// ❔ A blue circle with a white question mark inside
  question,
  /// ⚠️ A yellow triangle with a white exclamation mark inside
  warning,
  /// ❕ A blue circle with a white exclamation mark inside
  information,
  /// 🛡 A shield with a yellow and blue square pattern
  shield,
}

/// This extension allows adding members to the [WinIcon] enum.
/// 
/// In Dart 2.17 and later, this will be possible doable
/// without an extension.
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
