import 'dart:typed_data';

import 'package:flutter/services.dart';

typedef Id = int;

class BetrayalPlugin {
  static final BetrayalPlugin _instance = BetrayalPlugin._internal();
  factory BetrayalPlugin() => _instance;

  static const MethodChannel _channel = MethodChannel('betrayal');

  BetrayalPlugin._internal() {
    _channel.setMethodCallHandler(_handleMethod);
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

  Future<void> setIconFromPath(Id id, String path,
      {bool isShared = false}) async {
    await _channel.invokeMethod(
        'setIconFromPath', {'id': id, 'path': path, 'isShared': isShared});
  }

  Future<void> setIconAsWinIcon(Id id, int resourceId) async {
    await _channel
        .invokeMethod('setIconAsWinIcon', {'id': id, 'resourceId': resourceId});
  }

  Future<void> setIconFromPixels(
      Id id, int width, int height, Int32List pixels) async {
    await _channel.invokeMethod('setIconFromPixels',
        {'id': id, 'pixels': pixels, 'width': width, 'height': height});
  }
}
