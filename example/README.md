# How to use?

To add an icon to your app, simply use the [`TrayIconWidget`](../lib/src/widgets.dart).

```dart
import 'package:betrayal/betrayal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
}
```

Check out the [Widgets Api](widget_api/lib/main.dart) example to learn more about this approach.

## Ok, but I want to work with `TrayIcon`s directly, please!

Sure, you can use the [imperative api](../lib/src/imperative.dart) to create and control `TrayIcon`s directly.

```dart
final icon = TrayIcon();

await icon.setTooltip("🎭");
await icon.setImage(asset: "assets/dart.ico"));
await icon.show();
```

Just make sure to dispose of it and free its resources once you're done.

```dart
icon.dispose();
```

If you don't feel like managing an icon, you can still use a `TrayIconWidget` and get its underlying `TrayIcon` by calling `TrayIcon.of(context)`.

```dart
@override
Widget build(BuildContext context) {
  return TrayIconWidget(
    child: 
      // .............
      Builder(
        builder: (BuildContext context) {
          // The BuildContext must be from a child of `TrayIconWidget`,
          // otherwise the icon may not be found.
          return IconButton(
            onPressed: () => TrayIcon.of(context).setTooltip("🙇‍♂️"),
            icon: Icon(Icons.add)
          );
        }
      )
  );
}
```
