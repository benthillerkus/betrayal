// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'dart:typed_data';

import 'package:betrayal/src/plugin.dart';
import 'package:betrayal/src/win_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

/// A helper that sets the image of a [TrayIcon].
@immutable
class TrayIconImageDelegate {
  static final _logger = Logger('betrayal.image_delegate');

  /// A [TrayIconImageDelegate] that uses a `.ico` file.
  ///
  /// If both [uri] and [path] are given, [uri] takes precedence.
  /// [path] needs to use Windows style `\\` notation.
  TrayIconImageDelegate.fromPath({Uri? uri, String? path}) {
    if (uri == null && path == null) {
      throw ArgumentError("Either uri or path must be specified.");
    }

    if (uri != null) {
      if (uri.scheme != 'file') {
        throw ArgumentError("Only file:// URIs are supported.");
      }

      path = uri.toFilePath(windows: true);
    }

    if (!path!.endsWith(".ico")) {
      _logger.warning("""'$path' is not an .ico file.
Continuing under the assumption that only the file extension is wrong""");
    }

    setIcon = (id, plugin) => plugin.setImageFromPath(id, path!);
  }

  /// A [TrayIconImageDelegate] that uses a `.ico` file from the Flutter assets directory.
  TrayIconImageDelegate.fromAsset(String asset) {
    final path = p.joinAll(
        [p.dirname(Platform.resolvedExecutable), 'data/flutter_assets', asset]);

    setIcon = (id, plugin) => plugin.setImageFromPath(id, path);
  }

  /// A [TrayIconImageDelegate] that uses a Windows system icon.
  TrayIconImageDelegate.fromWinIcon(WinIcon winIcon) {
    setIcon = (id, plugin) => plugin.setImageAsWinIcon(id, winIcon.code);
  }

  /// A [TrayIconImageDelegate] that uses an RGBA image buffer.
  ///
  /// The buffer is expected to be in the format of a 32x32 RGBA image.
  TrayIconImageDelegate.fromBytes(ByteBuffer pixels) {
    if (pixels.lengthInBytes != 32 * 32 * 4) {
      throw ArgumentError(
          "The buffer must be 32x32 pixels and 4 bytes per pixel.");
    }
    setIcon = (id, plugin) =>
        plugin.setImageFromPixels(id, 32, 32, pixels.asInt32List());
  }

  /// A [TrayIconImageDelegate] that uses no image and will remove existing images.
  TrayIconImageDelegate.noImage() {
    setIcon = (id, plugin) => plugin.removeImage(id);
  }

  /// The call into the plugin to set the image for a [TrayIcon] with the given [id].
  @protected
  late final Future<void> Function(Id id, BetrayalPlugin plugin) setIcon;
}
