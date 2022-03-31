# betrayal

A tray icon plugin for Windows.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Development
## TBD

- FIXME Find out all possible errors and repackage / handle them
- TODO Write documentation
- TODO Support Windows default icons ([MAKEINTRESOURCE....](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-loadicona))
- TODO Support images
  - TODO Find out, communicate and memoize the correct system metrics (icon resolution)
- TODO Support interaction
  - TODO Support menus
- TODO Add function to configure a TrayIcon in one call (maybe via a dynamic map actually)
  - FIXME Use OnWidgetUpdated or smth like that to diff changes between widget dependencies and flush them to the plugin
- TODO Add second example using the Widget API
- TODO Support setting titlebar / application icon

## Style

Use [conventionalcommits.org/en/v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) for commits.

Scopes and their meaning:
- `(plugin):` internal changes mostly in the Dart part of the plugin
- `(windows):` internal changes mostly in the C++ part of the plugin
- `(api):` changes to the public api
- `(example):` any type of change in one of the examples
- `(readme):` edits to readme files; unrelated to source code

Use [dart.dev/guides/language/effective-dartdocumentation](https://dart.dev/guides/language/effective-dart/documentation) for docs.
