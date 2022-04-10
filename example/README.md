# How to use?

To add an icon to your app, simply use the [`TrayIconWidget`](https://github.com/benthillerkus/betrayal/blob/main/lib/src/widgets.dart).

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

Check out the [widgets api](https://github.com/benthillerkus/betrayal/blob/main/lib/src/widgets.dart) example to learn more about this approach
and have a look at [widgets_api](https://github.com/benthillerkus/betrayal/blob/main/example/widgets_api/lib/main.dart) for a small demo app that uses it.

[skeleton_example](https://github.com/benthillerkus/betrayal/blob/main/example/skeleton_example/lib/src/app.dart) is an abridged version of the Flutter skeleton template
that persists an icon over multiple pages.

## Ok, but I want to work with `TrayIcon`s directly, please!

Sure, you can use the [imperative api](https://github.com/benthillerkus/betrayal/blob/main/lib/src/imperative.dart) to create and control `TrayIcon`s directly.

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

Check out the [edit_icon](https://github.com/benthillerkus/betrayal/blob/main/example/edit_icon) example for a more complex app that uses the imperative api.

If you want to see how *Betrayal* can work with multiple icons and how to generate images at runtime through `Canvas` please look at the [add_many](https://github.com/benthillerkus/betrayal/blob/main/example/add_many/lib/main.dart)

## Is there a way to get rid of the log messages?

Yeah, you can change the log level, as seen in the [widgets_api](https://github.com/benthillerkus/betrayal/blob/main/example/widgets_api/README.md) example.

```dart
// sets `hierarchicalLoggingEnabled`
// from the `logging` package to `true`
BetrayalLogConfig.allowIndividualLevels();

// disables logging only for *betrayal*
BetrayalLogConfig.level = "OFF";
```

To learn more about logging in *betrayal* have a look at the implementation in [logging.dart](https://github.com/benthillerkus/betrayal/blob/main/lib/src/logging.dart).