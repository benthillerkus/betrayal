/// This library is not part of the public API, but feel free to use it.
/// However, note that trying to interfere with icons managed by a [TrayIcon]´
/// will break stuff.

import 'dart:math';
import 'dart:typed_data';

import 'package:betrayal/src/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'image.dart';
import 'win_icon.dart';
import 'win_event.dart';

part 'imperative.dart';
part 'widgets.dart';

/// An identifier.
///
/// The Windows api also supports UUIDs, but for now ints are fine.
///
/// 😡 Don't try to take the [Id] from a [TrayIcon]
/// and call the plugin directly with it!
typedef Id = int;

/// A singleton [MethodChannel] wrapper that communicates with the native plugin.
///
/// It will be lazily constructed
/// once it's needed by [TrayIcon] for the first time.
@protected
class BetrayalPlugin {
  static final BetrayalPlugin _instance = BetrayalPlugin._internal();

  /// Retrieves the singleton instance.
  factory BetrayalPlugin() => _instance;

  static const MethodChannel _channel = MethodChannel('betrayal');

  final _logger = Logger('betrayal.plugin');
  final _nativeLogger = Logger('betrayal.native');

  /// The singleton constructor.
  ///
  /// Once it is invoked, it will try to clear up any icons registered
  /// with the plugin.
  BetrayalPlugin._internal() {
    BetrayalLogConfig();
    _logger.finer('initializing plugin...');
    // This makes sure the plugin can be invoked
    // before `runApp` is called in main
    WidgetsFlutterBinding.ensureInitialized();

    _channel.setMethodCallHandler(_handleMethod);
    reset();
    _logger.info('connection initialized');
  }

  Future<dynamic> _handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "print":
        _nativeLogger.info(methodCall.arguments);
        break;
      case "logWindowProc":
        final args = methodCall.arguments;
        final int message = args["message"];
        final int wParam = args["wParam"];
        final int lParam = args["lParam"];
        final int hWnd = args["hWnd"];

        try {
          final action = fromCode(lParam);
          final icon = TrayIcon._allIcons[message - 0x400]!;
          _logger.fine(
              "${action.name} on $icon, wParam: ${wParam.toRadixString(16)}");
        } on Error {
          _logger.info(
              "message: 10b$message 0x${message.toRadixString(16)}, wParam: ${wParam.toRadixString(16)}, lParam: ${lParam.toRadixString(16)}, hWnd: $hWnd");
        }
        break;
    }
  }

  /// Removes and cleans up any icon managed by the plugin.
  @protected
  Future<void> reset() async {
    await _channel.invokeMethod('reset');
    _logger.finer('removed all icons');
  }

  /// Removes and cleans up a single item.
  ///
  /// This is the opposite of [addTray].
  @protected
  Future<void> disposeTray(Id id) async {
    await _channel.invokeMethod('disposeTray', {'id': id});
  }

  /// Creates a new tray icon.
  ///
  /// This is the opposite of [disposeTray].
  @protected
  Future<void> addTray(Id id) async {
    await _channel.invokeMethod('addTray', {'id': id});
  }

  /// Displays a tray icon.
  ///
  /// This is the opposite of [hideIcon].
  @protected
  Future<void> showIcon(Id id) async {
    await _channel.invokeMethod('showIcon', {'id': id});
  }

  /// Hides a tray icon.
  ///
  /// This is the opposite of [showIcon].
  @protected
  Future<void> hideIcon(Id id) async {
    await _channel.invokeMethod('hideIcon', {'id': id});
  }

  /// Sets the icon's tooltip.
  ///
  /// This is the oppose of [removeTooltip].
  @protected
  Future<void> setTooltip(Id id, String tooltip) async {
    await _channel.invokeMethod('setTooltip', {'id': id, 'tooltip': tooltip});
  }

  /// Removes the icon's tooltip.
  ///
  /// This is the opposite of [setTooltip].
  @protected
  Future<void> removeTooltip(Id id) async {
    await _channel.invokeMethod('removeTooltip', {'id': id});
  }

  /// Sets the icon's image, by loading an .ico file.
  ///
  /// The given path has to be normalized to Windows' `\` path format.
  ///
  /// This is the opposite of [removeImage].
  @protected
  Future<void> setImageFromPath(Id id, String path,
      {bool isShared = false}) async {
    await _channel.invokeMethod(
        'setImageFromPath', {'id': id, 'path': path, 'isShared': isShared});
  }

  /// Sets the icon's image, by loading a default icon.
  ///
  /// Check out the [WinIcon] enum for a list of available icons.
  @protected
  Future<void> setImageAsWinIcon(Id id, int resourceId) async {
    await _channel.invokeMethod(
        'setImageAsWinIcon', {'id': id, 'resourceId': resourceId});
  }

  /// Sets the icon's image, by loading a byte buffer.
  ///
  /// The buffer has to be in the format of a 32-bit RGBA image.
  /// [width] and [height] have to be equal and powers of 2.
  @protected
  Future<void> setImageFromPixels(
      Id id, int width, int height, Int32List pixels) async {
    await _channel.invokeMethod('setImageFromPixels',
        {'id': id, 'pixels': pixels, 'width': width, 'height': height});
  }

  /// Removes the current image.
  ///
  /// The previous image will be cleaned up, if needed.
  /// The flags required to show an image will be unset.
  /// And the changes will be registered with Windows.
  ///
  /// The result will be a transparent / blank icon.
  @protected
  Future<void> removeImage(Id id) async {
    await _channel.invokeMethod('removeImage', {'id': id});
  }
}
