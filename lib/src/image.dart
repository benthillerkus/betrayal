import 'dart:io';
import 'dart:typed_data';

import 'package:betrayal/src/plugin.dart';
import 'package:betrayal/src/win_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

/// A helper that sets the image of a [TrayIcon].
@immutable
class TrayIconImageDelegate {
  /// A [TrayIconImageDelegate] that loads an image from a `.ico` file.
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

    // path.endsWith(".ico");

    setIcon = (id, plugin) => plugin.setIconFromPath(id, path!);
  }

  /// A [TrayIconImageDelegate] that loads a `.ico` file from the Flutter assets directory.
  TrayIconImageDelegate.fromAsset(String asset) {
    final path = p.joinAll(
        [p.dirname(Platform.resolvedExecutable), 'data/flutter_assets', asset]);

    setIcon = (id, plugin) => plugin.setIconFromPath(id, path);
  }

  /// A [TrayIconImageDelegate] that sets an image from the default Windows icons.
  TrayIconImageDelegate.fromWinIcon(WinIcon winIcon) {
    setIcon = (id, plugin) => plugin.setIconAsWinIcon(id, winIcon.code);
  }

  /// A [TrayIconImageDelegate] that sets an image from a buffer.
  ///
  /// The buffer is expected to be in the format of a 32x32 RGBA image.
  TrayIconImageDelegate.fromBytes(ByteBuffer pixels) {
    if (pixels.lengthInBytes != 32 * 32 * 4) {
      throw ArgumentError(
          "The buffer must be 32x32 pixels and 4 bytes per pixel.");
    }
    setIcon = (id, plugin) =>
        plugin.setIconFromPixels(id, 32, 32, pixels.asInt32List());
  }

  /// The call into the plugin to set the image for a [TrayIcon] with the given [id].
  ///
  /// This is not part of the public API and usage is discouraged.
  late final Future<void> Function(Id id, BetrayalPlugin plugin) setIcon;
}
