[![pub score](https://github.com/benthillerkus/betrayal/actions/workflows/score.yml/badge.svg?branch=main)](https://github.com/benthillerkus/betrayal/actions/workflows/score.yml)
![joke shield[^1]](https://img.shields.io/badge/supports-windows%202000*-blue)

# betrayal

A plugin for the [taskbar notification area](https://devblogs.microsoft.com/oldnewthing/20030910-00/?p=42583#:~:text=Summary%3A%20It%20is%20never%20correct%20to%20refer%20to%20the%20notification%20area%20as%20the%20tray.%20It%20has%20always%20been%20called%20the%20%E2%80%9Cnotification%20area%E2%80%9D.) in Windows.

## Features

- Multiple tray icons
- Many options for setting the tray icon's image
  - `.ico` file either from the file system or the Flutter assets directory
  - Set the pixels directly through an image buffer - you can use this to dynamically create an image via canvas!
  - Use default system icons like the ❔ or the elevation prompt 🛡️
- Widget Api - treat the tray icon as part of your UI and compose it in your build methods

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Development
## TBD before v1

- FIXME Find out all possible errors and repackage / handle them
- TODO Write documentation
- TODO Find out, communicate and memoize the correct system metrics (icon resolution)
- TODO Support interaction
- TODO Logging

## Style

Use [conventionalcommits.org/en/v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) for commits.

Scopes and their meaning:
- [`(plugin)`](https://github.com/benthillerkus/betrayal/search?q=%28plugin%29&type=commits): internal changes mostly in the Dart part of the plugin
- [`(windows)`](https://github.com/benthillerkus/betrayal/search?q=%28windows%29&type=commits): internal changes mostly in the C++ part of the plugin
- [`(api)`](https://github.com/benthillerkus/betrayal/search?q=%28api%29&type=commits): changes to the public api
- [`(example)`](https://github.com/benthillerkus/betrayal/search?q=%28example%29&type=commits): any type of change in one of the examples
- [`(readme)`](https://github.com/benthillerkus/betrayal/search?q=%28readme%29&type=commits): edits to readme files; unrelated to source code

Tbh all of this needs to change once 1.0 is out lol

Use [dart.dev/guides/language/effective-dartdocumentation](https://dart.dev/guides/language/effective-dart/documentation) for docs.

[^1]: This is a lie. Flutter does not support Windows 2000. Betrayal.
