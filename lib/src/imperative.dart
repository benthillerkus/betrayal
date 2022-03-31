import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:betrayal/src/plugin.dart';
import 'package:betrayal/src/data.dart';
import 'package:betrayal/src/win_icon.dart';
import 'package:path/path.dart' as p;

class TrayIcon {
  static final BetrayalPlugin _plugin = BetrayalPlugin();
  static final Map<Id, TrayIcon> _allIcons = {};
  static final Random _random = Random();
  static Id _newId() => _random.nextInt(0x8FFF - 0x7FFF);

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

  void setIcon(
      {Picture? picture,
      Image? image,
      Uri? path,
      String? asset,
      WinIcon winIcon = WinIcon.question,
      bool freeResources = false}) async {
    _ensureIsActive();
    await _makeRealIfNeeded();

    if (picture != null) {
      if (freeResources) image?.dispose();
      image = await picture.toImage(32, 32);
      if (freeResources) picture.dispose();
    }

    if (image != null) {
      final bytes = (await image.toByteData(format: ImageByteFormat.rawRgba))!
          .buffer
          .asInt32List();

      await _plugin.setIconFromPixels(_id, image.width, image.height, bytes);

      if (freeResources) image.dispose();
    } else if (asset != null) {
      var res = p.joinAll([
        p.dirname(Platform.resolvedExecutable),
        'data/flutter_assets',
        asset
      ]);
      await _plugin.setIconFromPath(_id, res);
    } else if (path != null) {
      await _plugin.setIconFromPath(_id, path.toFilePath(windows: true));
    } else {
      await _plugin.setIconAsWinIcon(_id, winIcon.code);
    }
  }
}
