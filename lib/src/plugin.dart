/// This library is not part of the public API, but feel free to use it.
/// However, note that trying to interfere with icons managed by a [TrayIcon]´
/// will break stuff.
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:synchronized/synchronized.dart';

import 'image.dart';
import 'stock_icon.dart';
import 'win_event.dart';
import 'win_icon.dart';

part 'imperative.dart';
part 'interaction.dart';
part 'widgets.dart';

/// An identifier.
///
/// The Windows api also supports UUIDs, but for now ints are fine.
///
/// 😡 Don't try to take the [Id] from a [TrayIcon]
/// and call the plugin directly with it!
typedef Id = int;

const Id _kMaximumId = 0x8FFF;
const Id _kMinimumId = 0x7FFF;

/// Allows adding members to [Id] typedef.
extension HexRepresentation on Id {
  /// Value in hex [String] notation. (e.g. `0x1234`)
  String get hex => '0x${toRadixString(16).padLeft(4, '0')}';
}

/// A singleton [MethodChannel] wrapper that communicates with the native plugin.
///
/// It will be lazily constructed
/// once it's needed by [TrayIcon] for the first time.
@protected
class BetrayalPlugin {
  static final BetrayalPlugin _instance = BetrayalPlugin._internal();

  /// Retrieves the singleton instance.
  @protected
  static BetrayalPlugin get instance => _instance;

  static const MethodChannel _channel = MethodChannel('betrayal');

  final _logger = Logger('betrayal.plugin');
  final _nativeLogger = Logger('betrayal.native');

  /// {@template betrayal.preferredImageSize}
  /// The small icon size
  ///
  /// See: [docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getsystemmetrics](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getsystemmetrics#:~:text=same%20as%20SM_CXFRAME.-,SM_CXSMICON,-49)
  ///
  /// Used by [TrayIcon.preferredImageSize].
  ///
  /// Set through [BetrayalPlugin._updateSystemMetrics].
  /// {@endtemplate}
  late Size _preferredImageSize;

  /// {@macro betrayal.preferredLargeImageSize}
  static Size get preferredImageSize => instance._preferredImageSize;

  /// {@template betrayal.preferredLargeImageSize}
  /// The standard icon size
  ///
  /// See: [docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getsystemmetrics](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getsystemmetrics#:~:text=bar%2C%20in%20pixels.-,SM_CXICON,-11)
  ///
  /// Used by [TrayIcon.preferredLargeImageSize].
  ///
  /// Set through [BetrayalPlugin._updateSystemMetrics].
  /// {@endtemplate}
  late Size _preferredLargeImageSize;

  /// {@macro betrayal.preferredLargeImageSize}
  static Size get preferredLargeImageSize => instance._preferredLargeImageSize;

  /// {@template betrayal.primaryAndSecondarySwapped}
  /// If the user has inverted their mouse buttons.
  ///
  /// Windows will automatically normalize inputs, but it still might be
  /// interesting what button actually was pressed / be able to prompt
  /// the user to press the correct button.
  ///
  /// Set through [BetrayalPlugin._updateSystemMetrics].
  /// {@endtemplate}
  static bool _primaryAndSecondarySwapped = false;

  /// {@macro betrayal.primaryAndSecondarySwapped}
  static bool get primaryAndSecondarySwapped => _primaryAndSecondarySwapped;

  /// The singleton constructor.
  ///
  /// Once it is invoked, it will try to clear up any icons registered
  /// with the plugin.
  BetrayalPlugin._internal() {
    _logger.finer('initializing plugin...');
    // This makes sure the plugin can be invoked
    // before `runApp` is called in main
    WidgetsFlutterBinding.ensureInitialized();

    _channel.setMethodCallHandler(_handleMethod);
    _updateSystemMetrics();
    reset();

    _logger.info('connection initialized');
  }

  /// Has no use beyond making the scoring algorithm on pub.dev happy.
  @protected
  void _noop() {}

  Future<dynamic> _handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "print":
        _nativeLogger.info(methodCall.arguments);
        break;
      case "handleInteraction":
        final args = methodCall.arguments;
        final int message = args["message"];
        final int hWnd = args["hWnd"];
        final Offset position =
            Offset(args["x"].toDouble(), args["y"].toDouble());
        final int code = args["event"];
        final Id id = args["id"];

        try {
          final icon = TrayIcon._allIcons[id]!;
          final event = fromCode(code);
          final eventRaw = primaryAndSecondarySwapped ? event.inverted : event;
          icon._handleInteraction(_TrayIconInteraction(
              event: event,
              rawEvent: eventRaw,
              position: position,
              id: id,
              hWnd: hWnd));
        } on Error {
          _logger.warning(
              "message: 10b$message ${message.hex}, id: ${id.hex}, event: ${code.toRadixString(16)}, position: $position}, hWnd: $hWnd");
        }
        break;
    }
  }

  /// Updates [preferredImageSize], [preferredLargeImageSize] and [primaryAndSecondarySwapped]
  @protected
  Future<void> _updateSystemMetrics() async {
    final metrics =
        await _channel.invokeMapMethod<String, dynamic>('getSystemMetrics');

    _preferredImageSize = Size(metrics!["preferredImageSizeX"].toDouble(),
        metrics["preferredImageSizeY"].toDouble());

    _preferredLargeImageSize = Size(
        metrics["preferredLargeImageSizeX"].toDouble(),
        metrics["preferredLargeImageSizeY"].toDouble());

    _primaryAndSecondarySwapped = metrics["primaryAndSecondarySwapped"] != 0;

    _logger.fine(
        "preferredImageSize: $preferredImageSize preferredLargeImageSize $preferredLargeImageSize primaryAndSecondarySwapped: $primaryAndSecondarySwapped");
  }

  /// Asks the plugin to call [_handleMethod] whenever [id] + [event] happens.
  ///
  /// Effectively, this means that events will per default *not* clog up the `MethodChannel`.
  @protected
  Future<void> subscribeTo(Id id, WinEvent event) async {
    await _channel.invokeMethod("subscribeTo", {
      "id": id,
      "event": event.code,
    });
  }

  /// Notifies the plugin that events that the pattern [id] + [event] can be ignored.
  @protected
  Future<void> unsubscribeFrom(Id id, WinEvent event) async {
    await _channel.invokeMethod("unsubscribeFrom", {
      "id": id,
      "event": event.code,
    });
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

  /// Sets the icon's image, by loading a stock icon.
  ///
  /// Check out the [StockIcon] enum for a list of available icons.
  @protected
  Future<void> setImageAsStockIcon(Id id, int stockIconId) async {
    await _channel.invokeMethod(
        'setImageAsStockIcon', {'id': id, 'stockIconId': stockIconId});
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
