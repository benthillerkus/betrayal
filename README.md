[skip to content](#usage)

<p align="center">
  <a href="https://betrayal.bent.party">
    <img src="https://raw.githubusercontent.com/benthillerkus/betrayal/main/asset/logo.webp" height="280">
  </a>
</p>

<p align="center">
A capable tray icon plugin for Windows.
</p>

<table border="0" align="center">
  <tr>
    <td>
    </td>
  </tr>
  <tr>
    <td>
      <a href="https://pub.dev/packages/betrayal">🔗 package on pub.dev</a><br>
      <a href="https://github.com/benthillerkus/betrayal">🔗 source on github.com</a><br>
      <a href="https://pub.dev/documentation/betrayal">🔗 dart docs api reference</a>
    </td>
    <td>
      <pre><br>
Manage multiple icons 👨‍👩‍👦‍👦,<br>generate their images at runtime 🎨<br>and compose them just like a widget 🎶
        </pre>
    </td>
  </tr>
</table>

## Features

[![pub score](https://img.shields.io/pub/points/betrayal)](https://pub.dev/packages/betrayal/score)
[![pub version (including pre-releases)](https://img.shields.io/pub/v/betrayal?include_prereleases)](https://pub.dev/packages/betrayal/versions)
[![pub publisher](https://img.shields.io/pub/publisher/betrayal)](https://pub.dev/publishers/bent.party/packages)

- Control multiple tray icons
- Many options for setting the tray icons image
  - `.ico` file either from the file system or the Flutter assets directory
  - Set the pixels directly through an image buffer - you can use this to dynamically create an image via canvas!
  - Use default system icons like the ❔ or the elevation prompt 🛡️
- Widget api - treat the tray icon as part of your UI and compose it in your build methods



https://user-images.githubusercontent.com/29630575/163495162-1cbdbc94-095f-48c6-ad86-a1f5ee809481.mp4



## Usage

After you've added *betrayal* to your dependencies via `flutter pub add betrayal` and `flutter pub get`,
you can start to use it:

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
      // The icon will be visible aslong as the [TrayIconWidget] will be built
      child: TrayIconWidget(
        winIcon: WinIcon.application,
        tooltip: "Here I am!"
        child: FlutterLogo()
      )
    )
  )
);
```

If you just want a tray icon, that's pretty much all you need to know.

There is, however, also a quick-guide [README.md](https://github.com/benthillerkus/betrayal/tree/main/example), four example applications and of course the [API docs](https://pub.dev/documentation/betrayal/latest/betrayal/betrayal-library.html), if you do want to learn more.

Don't hesitate to [file an issue](https://github.com/benthillerkus/betrayal/issues), I'll have a look at it eventually 😊

# Development

## Style

Use [conventionalcommits.org/en/v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) for commits. <br>
&nbsp;&nbsp;&nbsp;&nbsp;see [release.yml](https://github.com/benthillerkus/betrayal/blob/main/.github/workflows/release.yml) for a list of currently allowed commit types <br>
Use [dart.dev/guides/language/effective-dartdocumentation](https://dart.dev/guides/language/effective-dart/documentation) for docs.

## Overview

<details>
  <summary>Mermaid diagram of the architecture</summary>
  
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

</details>
