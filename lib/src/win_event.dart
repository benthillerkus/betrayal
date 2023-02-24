import 'package:flutter/widgets.dart';

/// Represents constants in WinUser.h
enum WinEvent {
  /// `0x0400` equivalent to `onTap`
  select,

  /// `0x007b` equivalent to `onSecondaryTap`
  ///
  /// https://docs.microsoft.com/en-us/windows/win32/menurc/wm-contextmenu
  contextMenu,

  /// `0x0200`
  mouseMove,

  /// `0x0201` equivalent to `onTapDown`
  leftButtonDown,

  /// `0x0202` equivalent to `onTapUp`
  leftButtonUp,

  /// `0x0203` equivalent to `onDoubleTap`
  leftButtonDoubleClick,

  /// `0x0204` equivalent to `onSecondaryTapDown`
  rightButtonDown,

  /// `0x0205` equivalent to `onSecondaryTapUp`
  rightButtonUp,

  /// `0x0206`
  rightButtonDoubleClick,

  /// `0x0207` equivalent to `onTertiaryTapDown`
  middleButtonDown,

  /// `0x0208` equivalent to `onTertiaryTapUp`
  middleButtonUp,

  /// `0x0209`
  middleButtonDoubleClick,
}

/// Returns the [WinEvent] for the given [code].
@protected
WinEvent fromCode(int code) {
  switch (code) {
    case 0x0400:
      return WinEvent.select;
    case 0x007b:
      return WinEvent.contextMenu;
    case 0x0200:
      return WinEvent.mouseMove;
    case 0x0201:
      return WinEvent.leftButtonDown;
    case 0x0202:
      return WinEvent.leftButtonUp;
    case 0x0203:
      return WinEvent.leftButtonDoubleClick;
    case 0x0204:
      return WinEvent.rightButtonDown;
    case 0x0205:
      return WinEvent.rightButtonUp;
    case 0x0206:
      return WinEvent.rightButtonDoubleClick;
    case 0x0207:
      return WinEvent.middleButtonDown;
    case 0x0208:
      return WinEvent.middleButtonUp;
    case 0x0209:
      return WinEvent.middleButtonDoubleClick;
  }
  throw ArgumentError.value(code, "code", "Unknown code");
}

/// This extension allows adding members to the [WinEvent] enum.
///
/// {@template betrayal.enum_extension}
/// In Dart 2.17 and later, this will be doable
/// without an extension.
/// {@endtemplate}
extension EventCodes on WinEvent {
  /// The internal constant used by Windows.
  int get code {
    switch (this) {
      case WinEvent.select:
        return 0x0400;
      case WinEvent.contextMenu:
        return 0x007b;
      case WinEvent.mouseMove:
        return 0x0200;
      case WinEvent.leftButtonDown:
        return 0x0201;
      case WinEvent.leftButtonUp:
        return 0x0202;
      case WinEvent.leftButtonDoubleClick:
        return 0x0203;
      case WinEvent.rightButtonDown:
        return 0x0204;
      case WinEvent.rightButtonUp:
        return 0x0205;
      case WinEvent.rightButtonDoubleClick:
        return 0x0206;
      case WinEvent.middleButtonDown:
        return 0x0207;
      case WinEvent.middleButtonUp:
        return 0x0208;
      case WinEvent.middleButtonDoubleClick:
        return 0x0209;
    }
  }

  /// Get the opposite event (left = right, right = left)
  WinEvent get inverted {
    switch (this) {
      case WinEvent.leftButtonUp:
        return WinEvent.rightButtonUp;
      case WinEvent.leftButtonDown:
        return WinEvent.rightButtonDown;
      case WinEvent.leftButtonDoubleClick:
        return WinEvent.rightButtonDoubleClick;
      case WinEvent.rightButtonUp:
        return WinEvent.leftButtonUp;
      case WinEvent.rightButtonDown:
        return WinEvent.leftButtonDown;
      case WinEvent.rightButtonDoubleClick:
        return WinEvent.leftButtonDoubleClick;
      default:
        return this;
    }
  }
}
