part of 'plugin.dart';

/// A widget that can be used to add a [TrayIcon] to the system tray.
///
/// The icons lifecycle is tied to this widgets [_TrayIconWidgetState].
///
/// If an icon persists after navigation and you want it gone, you'll
/// have to manually remove it.
/// ```dart
/// TrayIcon.of(context).hide();
/// ```
class TrayIconWidget extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Whether the [TrayIcon] should be shown or hidden.
  ///
  /// A hidden [TrayIcon] will not be in the system tray.
  /// But its state will be remembered by the plugin,
  /// so that it can be shown again later.
  ///
  /// If `visible == null` the icon will remain as-is.
  final bool? visible;

  /// The tooltip to show when hovering over the [TrayIcon].
  ///
  /// If `tooltip == null`, the current tooltip will be kept.
  /// If `tooltip == ''`, the tooltip will be removed.
  final String? tooltip;

  /// If `true`, the [TrayIcon] resource this widget manages
  /// will be accessible via `TrayIcon.of(context)`.
  ///
  /// If `false`, this widget doesn't have to update
  /// all properties of the [TrayIcon] resource, whenever
  /// it is changed as it can know what properties have changed.
  final bool addToContext;

  late final TrayIconImageDelegate? _delegate;

  late final Map<WinEvent, _EventCallback> _callbacks;

  /// Manages a [TrayIcon] as a [StatefulWidget].
  ///
  /// The underlying resource will automatically be disposed according to the
  /// lifecycle of the [StatefulWidget].
  ///
  /// Rebuilding this [TrayIconWidget] will different parameters will update the icon.
  ///
  /// Contrary to [TrayIcon.setImage], if [tooltip] or any of the image related fields
  /// are `null`, the current values are kept. This is to ensure that rebuilds
  /// don't interfere with using the [TrayIcon] widget directly through.
  /// [TrayIcon.of(BuildContext context)].
  ///
  /// {@macro betrayal.icon.image_parameters}
  TrayIconWidget(
      {Key? key,
      required this.child,
      this.visible = true,
      this.addToContext = true,
      this.tooltip,
      _EventCallback onTap,
      _EventCallback onSecondaryTap,
      _EventCallback onTapDown,
      _EventCallback onSecondaryTapDown,
      _EventCallback onTertiaryTapDown,
      _EventCallback onTapUp,
      _EventCallback onSecondaryTapUp,
      _EventCallback onTertiaryTapUp,
      _EventCallback onDoubleTap,
      _EventCallback onSecondaryDoubleTap,
      _EventCallback onTertiaryDoubleTap,
      _EventCallback onPointerMove,
      TrayIconImageDelegate? imageDelegate,
      ByteBuffer? imagePixels,
      String? imageAsset,
      Uri? imagePath,
      StockIcon? stockIcon,
      WinIcon? winIcon})
      : super(key: key) {
    if (imageDelegate != null) {
      _delegate = imageDelegate;
    } else if (imagePixels != null) {
      _delegate = TrayIconImageDelegate.fromBytes(imagePixels);
    } else if (imageAsset != null) {
      _delegate = TrayIconImageDelegate.fromAsset(imageAsset);
    } else if (imagePath != null) {
      _delegate = TrayIconImageDelegate.fromPath(uri: imagePath);
    } else if (stockIcon != null) {
      _delegate = TrayIconImageDelegate.fromStockIcon(stockIcon);
    } else if (winIcon != null) {
      _delegate = TrayIconImageDelegate.fromWinIcon(winIcon);
    } else {
      _delegate = null;
    }

    _callbacks = {
      WinEvent.select: onTap,
      WinEvent.leftButtonDoubleClick: onDoubleTap,
      WinEvent.leftButtonDown: onTapDown,
      WinEvent.leftButtonUp: onTapUp,
      WinEvent.contextMenu: onSecondaryTap,
      WinEvent.rightButtonDown: onSecondaryTapDown,
      WinEvent.rightButtonUp: onSecondaryTapUp,
      WinEvent.rightButtonDoubleClick: onSecondaryDoubleTap,
      WinEvent.middleButtonDown: onTertiaryTapDown,
      WinEvent.middleButtonUp: onTertiaryTapUp,
      WinEvent.middleButtonDoubleClick: onTertiaryDoubleTap,
      WinEvent.mouseMove: onPointerMove,
    };
  }

  @override
  State<TrayIconWidget> createState() => _TrayIconWidgetState();
}

class _TrayIconHeritage extends InheritedWidget {
  final TrayIcon icon;

  const _TrayIconHeritage({required Widget child, required this.icon})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class _TrayIconWidgetState extends State<TrayIconWidget> {
  late final TrayIcon _icon = TrayIcon();
  late final _logger = Logger("betrayal.widget.${_icon._id.hex}");

  @override
  void activate() {
    _icon.show();
    _logger.info("reinserted. icon shown again.");
    super.activate();
  }

  @override
  Widget build(BuildContext context) => widget.addToContext
      ? _TrayIconHeritage(child: widget.child, icon: _icon)
      : widget.child;

  @override
  void deactivate() {
    _icon.hide();
    _logger.info("removed. icon hidden.");
    super.deactivate();
  }

  @override
  void didUpdateWidget(covariant TrayIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _logger.fine("updating icon…");
    _icon._callbacks = widget._callbacks;
    if (widget.visible != null && !widget.visible!) {
      _icon.hide();
      return;
    }
    if (widget.addToContext || widget.tooltip != oldWidget.tooltip) {
      if (widget.tooltip != null) _icon.setTooltip(widget.tooltip!);
    }
    if (widget.addToContext || widget._delegate != oldWidget._delegate) {
      if (widget._delegate != null) _icon.setImage(delegate: widget._delegate);
    }
    if (widget.visible != null) {
      _icon.show();
    }
  }

  @override
  void dispose() {
    _logger.info("disposing…");
    _icon.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget._delegate != null) _icon.setImage(delegate: widget._delegate);
    if (widget.tooltip != null) _icon.setTooltip(widget.tooltip!);
    if (widget.visible ?? false) _icon.show();
    _icon._callbacks = widget._callbacks;
  }
}
