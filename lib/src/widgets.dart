part of 'imperative.dart';

/// A widget that can be used to add a [TrayIcon] to the system tray.
class TrayIconWidget extends StatefulWidget {
  /// Manages a [TrayIcon] as a [StatefulWidget].
  ///
  /// The underlying resource will automatically be disposed according to the
  /// lifecycle of the [StatefulWidget].
  ///
  /// Rebuilding this [TrayIconWidget] will different parameters will update the icon.
  ///
  /// Contrary to [TrayIcon.setImage], if [tooltip] or any of the image related fields
  /// are not set, the current values are kept. This is to ensure that rebuilds
  /// don't interfere with using the [TrayIcon] widget directly through.
  /// [TrayIcon.of(BuildContext context)].
  TrayIconWidget(
      {Key? key,
      required this.child,
      this.visible = true,
      this.addToContext = true,
      this.tooltip,
      TrayIconImageDelegate? imageDelegate,
      ByteBuffer? imagePixels,
      String? imageAsset,
      Uri? imagePath,
      WinIcon? winIcon})
      : super(key: key) {
    if (imageDelegate != null) {
      delegate = imageDelegate;
    } else if (imagePixels != null) {
      delegate = TrayIconImageDelegate.fromBytes(imagePixels);
    } else if (imageAsset != null) {
      delegate = TrayIconImageDelegate.fromAsset(imageAsset);
    } else if (imagePath != null) {
      delegate = TrayIconImageDelegate.fromPath(uri: imagePath);
    } else if (winIcon != null) {
      delegate = TrayIconImageDelegate.fromWinIcon(winIcon);
    } else {
      delegate = null;
    }
  }

  final Widget child;
  final bool visible;
  final String? tooltip;

  /// If `true`, the [TrayIcon] resource this widget manages
  /// will be accessible via `TrayIcon.of(context)`.
  ///
  /// If `false`, this widget doesn't have to update
  /// all properties of the [TrayIcon] resource, whenever
  /// it is changed as it can know what properties have changed.
  final bool addToContext;
  late final TrayIconImageDelegate? delegate;

  @override
  State<TrayIconWidget> createState() => _TrayIconWidgetState();
}

class _TrayIconWidgetState extends State<TrayIconWidget> {
  late final TrayIcon _icon = TrayIcon();

  @override
  void initState() {
    super.initState();
    if (!widget.visible) return;
    if (widget.delegate != null) _icon.setImage(delegate: widget.delegate);
    if (widget.tooltip != null) _icon.setTooltip(widget.tooltip!);
    _icon.show();
  }

  @override
  void didUpdateWidget(covariant TrayIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.visible) {
      _icon.hide();
      return;
    }
    if (widget.addToContext ||
        !oldWidget.visible ||
        widget.tooltip != oldWidget.tooltip) {
      if (widget.tooltip != null) _icon.setTooltip(widget.tooltip!);
    }
    if (widget.addToContext ||
        !oldWidget.visible ||
        widget.delegate != oldWidget.delegate) {
      if (widget.delegate != null) _icon.setImage(delegate: widget.delegate);
    }
    _icon.show();
  }

  @override
  void deactivate() {
    _icon.hide();
    super.deactivate();
  }

  @override
  void activate() {
    _icon.show();
    super.activate();
  }

  @override
  void dispose() {
    _icon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.addToContext
      ? _TrayIconHeritage(child: widget.child, icon: _icon)
      : widget.child;
}

class _TrayIconHeritage extends InheritedWidget {
  const _TrayIconHeritage({required Widget child, required this.icon})
      : super(child: child);

  final TrayIcon icon;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
