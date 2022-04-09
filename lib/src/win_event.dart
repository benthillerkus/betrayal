import 'package:flutter/widgets.dart';

/// Represents constants in WinUser.h
enum WinEvent {
  /// `0x200`, equivalent to `EVENT_SYSTEM_MOVESIZESTART`
  mouseMove,

  /// `0x201`, equivalent to `onTapDown`
  leftButtonDown,

  /// `0x202`, equivalent to `onTapUp`
  leftButtonUp,

  /// `0x203`, equivalent to `onDoubleTap`
  leftButtonDoubleClick,

  /// `0x204`, equivalent to `onSecondaryTapDown`
  rightButtonDown,

  /// `0x205`, equivalent to `onSecondaryTapUp`
  rightButtonUp,

  /// `0x206`
  rightButtonDoubleClick,

  /// `0x207`, equivalent to `onTertiaryTapDown`
  middleButtonDown,

  /// `0x207`, equivalent to `onTertiaryTapUp`
  middleButtonUp,

  /// `0x207`
  middleButtonDoubleClick,
}

/// Returns the [WinEvent] for the given [code].
@protected
WinEvent fromCode(int code) {
  switch (code) {
    case 0x200:
      return WinEvent.mouseMove;
    case 0x201:
      return WinEvent.leftButtonDown;
    case 0x202:
      return WinEvent.leftButtonUp;
    case 0x203:
      return WinEvent.leftButtonDoubleClick;
    case 0x204:
      return WinEvent.rightButtonDown;
    case 0x205:
      return WinEvent.rightButtonUp;
    case 0x206:
      return WinEvent.rightButtonDoubleClick;
    case 0x207:
      return WinEvent.middleButtonDown;
    case 0x208:
      return WinEvent.middleButtonUp;
    case 0x209:
      return WinEvent.middleButtonDoubleClick;
  }
  throw ArgumentError.value(code, "code", "Unknown code");
}

/// This extension allows adding members to the [WinEvent] enum.
///
/// In Dart 2.17 and later, this will be possible doable
/// without an extension.
extension EventCodes on WinEvent {
  /// The internal constant used by Windows.
  int get code {
    switch (this) {
      case WinEvent.mouseMove:
        return 0x200;
      case WinEvent.leftButtonDown:
        return 0x201;
      case WinEvent.leftButtonUp:
        return 0x202;
      case WinEvent.leftButtonDoubleClick:
        return 0x203;
      case WinEvent.rightButtonDown:
        return 0x204;
      case WinEvent.rightButtonUp:
        return 0x205;
      case WinEvent.rightButtonDoubleClick:
        return 0x206;
      case WinEvent.middleButtonDown:
        return 0x207;
      case WinEvent.middleButtonUp:
        return 0x208;
      case WinEvent.middleButtonDoubleClick:
        return 0x209;
    }
  }
}
