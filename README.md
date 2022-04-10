[![pub score](https://github.com/benthillerkus/betrayal/actions/workflows/score.yml/badge.svg?branch=main)](https://github.com/benthillerkus/betrayal/actions/workflows/score.yml)
![pub version (including pre-releases)](https://img.shields.io/pub/v/betrayal?include_prereleases)
![joke shield[^1]](https://img.shields.io/badge/supports-windows%202000*-blue)
![pub publisher](https://img.shields.io/pub/publisher/betrayal)

# betrayal

A capable tray icon[^2] plugin for Windows. Manage multiple icons 👨‍👩‍👦‍👦, generate their images at runtime 🎨 and compose them as if they were a regular widget 🎶

## Features

- Control multiple tray icons
- Many options for setting the tray icons image
  - `.ico` file either from the file system or the Flutter assets directory
  - Set the pixels directly through an image buffer - you can use this to dynamically create an image via canvas!
  - Use default system icons like the ❔ or the elevation prompt 🛡️
- Widget api - treat the tray icon as part of your UI and compose it in your build methods

## Usage
```dart
import 'package:betrayal/betrayal.dart';

// ...

@override
Widget build(BuildContext context) => MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: const Text("Look at the system tray 👀")
    ),
    body: Center(
      child: TrayIconWidget(
        winIcon: WinIcon.application,
        tooltip: "Here I am!"
        child: FlutterLogo()
      )
    )
  )
);
```

Please refer to the [example subdirectory](https://github.com/benthillerkus/betrayal/tree/main/example) for more [information](https://github.com/benthillerkus/betrayal/blob/main/example/README.md) and code.

# Development
## TBD before v1

- FIXME Find out all possible errors and repackage / handle them
- TODO Find out, communicate and memoize the correct system metrics (icon resolution)
- TODO Support interaction

## Style

Use [conventionalcommits.org/en/v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) for commits. <br>
Use [dart.dev/guides/language/effective-dartdocumentation](https://dart.dev/guides/language/effective-dart/documentation) for docs.

## Overview

```mermaid
  graph LR;
    BetrayalPlugin o----o |connects via platform channel to| betrayal_plugin.cpp
    subgraph dart
    TrayIconWidget -- manages --> TrayIcon -- calls --> BetrayalPlugin
    TrayIcon -- uses --> TrayIconImageDelegate -- calls --> BetrayalPlugin
    BetrayalLogConfig
    end
    subgraph native
    betrayal_plugin.cpp -- holds --> IconManager.hpp
    IconManager.hpp -- provides TrayIcon.hpp to --> betrayal_plugin.cpp
    betrayal_plugin.cpp -- calls --> TrayIcon.hpp
    end
    click BetrayalPlugin "https://github.com/benthillerkus/betrayal/blob/main/lib/src/plugin.dart"
    click TrayIcon "https://github.com/benthillerkus/betrayal/blob/main/lib/src/imperative.dart"
    click TrayIconWidget "https://github.com/benthillerkus/betrayal/blob/main/lib/src/widgets.dart"
    click TrayIconImageDelegate "https://github.com/benthillerkus/betrayal/blob/main/lib/src/image.dart"
    click betrayal_plugin.cpp "https://github.com/benthillerkus/betrayal/blob/main/windows/betrayal_plugin.cpp"
    click IconManager.hpp "https://github.com/benthillerkus/betrayal/blob/main/windows/icon_manager.hpp"
    click TrayIcon.hpp "https://github.com/benthillerkus/betrayal/blob/main/windows/tray_icon.hpp"
```

[^1]: This is a lie. Flutter does not support Windows 2000. Betrayal.
[^2]: It's actually called the notification area [according to Raymond Chen](https://devblogs.microsoft.com/oldnewthing/20030910-00/?p=42583#:~:text=Summary%3A%20It%20is%20never%20correct%20to%20refer%20to%20the%20notification%20area%20as%20the%20tray.%20It%20has%20always%20been%20called%20the%20%E2%80%9Cnotification%20area%E2%80%9D.)
