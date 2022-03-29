// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadicona

enum WinIcon {
  application,
  error,
  warning,
  information,
  question,
  shield,
}

extension IconCodes on WinIcon {
  int get code {
    switch (this) {
      case WinIcon.application:
        return 32512;
      case WinIcon.error:
        return 32516;
      case WinIcon.warning:
        return 32515;
      case WinIcon.information:
        return 32516;
      case WinIcon.question:
        return 32514;
      case WinIcon.shield:
        return 32518;
    }
  }
}
