# Betrayal *`select_image`* example

This example shows you how…

- …to use the imperative api in a more complex application
- …use the `image` library to set any image from disk as a tray icon
- …use the `contextual_menu` library to create a context menu

## WTF is going on in the code?

This example uses a custom [`ElementSelector`](lib/view/element_selector/selectable.dart) widget. This widget wraps a [`PageView`](https://api.flutter.dev/flutter/widgets/PageView-class.html) and has animations when items are added or removed.

The `ElementSelector` requires an [`ElementSelectorDelegate<T>`](lib/view/element_selector/delegate.dart), which holds all of the stuff you want to be able to select. It's a List wrapper, basically.

The associated `T` type of the `ElementSelector` needs to be some [`SelectableData`](lib/view/element_selector/data.dart).
As a baseline this class holds a name, and a builder function to return how the element should look.

Since we want to associate each [`Selectable`](lib/view/element_selector/selectable.dart) with a [`TrayIcon`](../../lib/src/imperative.dart), we extend `SelectableData` to additionally hold a [`TrayIconImageDelegate`](../../lib/src/image.dart). This image delegate holds a function that tells a tray icon how to set its image.

So by changing the `TrayIconImageDelegate` we can change how the `TrayIcon` looks!
