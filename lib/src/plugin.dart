import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef Id = int;

class BetrayalPlugin {
  static final BetrayalPlugin _instance = BetrayalPlugin._internal();
  factory BetrayalPlugin() => _instance;

  static const MethodChannel _channel = MethodChannel('betrayal');

  BetrayalPlugin._internal() {
    WidgetsFlutterBinding.ensureInitialized();
    _channel.setMethodCallHandler(_handleMethod);
    reset();
  }

  Future<dynamic> _handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "print":
        print(methodCall.arguments);
        break;
      case "logWindowProc":
        final args = methodCall.arguments;
        final message = args["message"];
        final wParam = args["wParam"];
        final lParam = args["lParam"];
        final hWnd = args["hWnd"];
        print(
            "message: $message, wParam: $wParam, lParam: $lParam, hWnd: $hWnd");
        break;
    }
  }

  /// Removes any residual icons managed by the plugin.
  Future<void> reset() async {
    await _channel.invokeMethod('reset');
  }

  Future<void> disposeTray(Id id) async {
    await _channel.invokeMethod('disposeTray', {'id': id});
  }

  Future<void> addTray(Id id) async {
    await _channel.invokeMethod('addTray', {'id': id});
  }

  Future<void> showIcon(Id id) async {
    await _channel.invokeMethod('showIcon', {'id': id});
  }

  Future<void> hideIcon(Id id) async {
    await _channel.invokeMethod('hideIcon', {'id': id});
  }

  Future<void> setTooltip(Id id, String tooltip) async {
    await _channel.invokeMethod('setTooltip', {'id': id, 'tooltip': tooltip});
  }

  Future<void> removeTooltip(Id id) async {
    await _channel.invokeMethod('removeTooltip', {'id': id});
  }

  Future<void> setImageFromPath(Id id, String path,
      {bool isShared = false}) async {
    await _channel.invokeMethod(
        'setImageFromPath', {'id': id, 'path': path, 'isShared': isShared});
  }

  Future<void> setImageAsWinIcon(Id id, int resourceId) async {
    await _channel.invokeMethod(
        'setImageAsWinIcon', {'id': id, 'resourceId': resourceId});
  }

  Future<void> setImageFromPixels(
      Id id, int width, int height, Int32List pixels) async {
    await _channel.invokeMethod('setImageFromPixels',
        {'id': id, 'pixels': pixels, 'width': width, 'height': height});
  }

  Future<void> removeImage(Id id) async {
    await _channel.invokeMethod('removeImage', {'id': id});
  }
}
