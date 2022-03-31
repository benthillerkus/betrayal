import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:betrayal/src/image.dart';
import 'package:betrayal/src/plugin.dart';
import 'package:betrayal/src/data.dart';
import 'package:betrayal/src/win_icon.dart';

class TrayIcon {
  static final BetrayalPlugin _plugin = BetrayalPlugin();
  static final Map<Id, TrayIcon> _allIcons = {};
  static final Random _random = Random();
  static Id _newId() => _random.nextInt(0x8FFF - 0x7FFF);

  /// The id used by Windows to distinguish this icon.
  final Id _id;
  final TrayIconData data;
  bool _isVisible = false;
  bool get isVisible => _isVisible;

  bool _isActive = false;
  bool get isActive => _isActive;
  late StackTrace _disposedAt;

  /// `true` if the icon has been constructed in native code.
  /// This is deferred until usage, because constructors can't be `async`.
  bool _isReal = false;

  TrayIcon(this.data) : _id = _newId() {
    _allIcons[_id] = this;
    _isActive = true;
  }

  void dispose() async {
    _isActive = false;
    if (_isReal) {
      await _plugin.disposeTray(_id);
    }
    _allIcons.remove(_id);

    _disposedAt = StackTrace.current;
  }

  Future<void> _makeRealIfNeeded() async {
    if (!_isReal) {
      await _plugin.addTray(_id);
      _isReal = true;
    }
  }

  void _ensureIsActive() {
    if (!_isActive) {
      throw StateError(
          'TrayIcon is not active anymore.\n\nIt was disposed at:\n${_disposedAt.toString()}\nCurrent StackTrace:');
    }
  }

  void show() async {
    _ensureIsActive();
    if (_isVisible) return;
    await _makeRealIfNeeded();
    await _plugin.showIcon(_id);
    _isVisible = true;
  }

  void hide() async {
    _ensureIsActive();
    if (!_isVisible) return;
    if (!_isReal) return;

    await _plugin.hideIcon(_id);
    _isVisible = false;
  }

  void setTooltip(String tooltip) async {
    _ensureIsActive();
    await _makeRealIfNeeded();
    await _plugin.setTooltip(_id, tooltip);
  }

  /// Sets the image on this icon.
  ///
  /// If multiple arguments are passed, they are resolved in this order:
  /// 1. [imageDelegate]
  /// 2. [pixels]
  /// 3. [path]
  /// 4. [asset]
  /// 5. [winIcon]
  void setIcon({
    TrayIconImageDelegate? imageDelegate,
    Uri? path,
    ByteBuffer? pixels,
    String? asset,
    WinIcon winIcon = WinIcon.question,
  }) async {
    _ensureIsActive();
    await _makeRealIfNeeded();

    if (imageDelegate != null) {
    } else if (pixels != null) {
      imageDelegate = TrayIconImageDelegate.fromBytes(pixels);
    } else if (asset != null) {
      imageDelegate = TrayIconImageDelegate.fromAsset(asset);
    } else if (path != null) {
      imageDelegate = TrayIconImageDelegate.fromPath(uri: path);
    } else {
      imageDelegate = TrayIconImageDelegate.fromWinIcon(winIcon);
    }
    await imageDelegate.setIcon(_id, _plugin);
  }
}
