part of 'plugin.dart';

/// A data class to store events fired by native code.
///
/// Interactions / events are identified by [id] + [event] + [hWnd].
///
/// If the user has set their mouse buttons to be inverted,
/// [rawEvent] will be the event that was *actually* fired,
/// and [event] will be the semantically correct one.
///
/// {@template betrayal.expose_more_members_on_interaction}
/// If you need access to more data than the [_TrayIconInteraction.position], please [file an issue](https://github.com/benthillerkus/betrayal/issues/new).
/// {@endtemplate}
@immutable
class _TrayIconInteraction {
  final Offset position;
  final int hWnd;
  final WinEvent event;
  final WinEvent rawEvent;
  final Id id;

  const _TrayIconInteraction(
      {required this.event,
      required this.rawEvent,
      required this.position,
      required this.id,
      required this.hWnd});

  @override
  String toString() {
    if (rawEvent != event) {
      return "${rawEvent.name} (interpreted as ${event.name}) at $position";
    }

    return "${event.name} at $position";
  }
}

typedef _EventCallback = void Function(Offset position)?;

/// Gives the [TrayIcon] the ability to react to [WinEvent]s.
///
/// Relies on the [TrayIcon.__callbacks] map to store the callbacks.
extension InteractionHandling on TrayIcon {
  /// {@template betrayal.interaction_handling.set}
  /// Register this callback to be called, whenever the associated [WinEvent] is fired.
  ///
  /// If `null` is passed, the callback will be removed.
  /// This should mean better performance as the native code
  /// won't have to call into dart for this even anymore.
  ///
  /// {@macro betrayal.expose_more_members_on_interaction}
  ///
  /// It would be possible to also expose the [hWnd] and [WinEvent] as well (See [_TrayIconInteraction]).
  /// {@endtemplate}
  set onTap(_EventCallback onTap) =>
      _manageEventSubscription(WinEvent.select, onTap);

  /// {@template betrayal.interaction_handling.get}
  /// The callback that is currently being run `onTap`.
  ///
  /// If `null`, this [WinEvent] can be skipped.
  /// {@endtemplate}
  _EventCallback get onTap => _callbacks[WinEvent.select];

  /// {@macro betrayal.interaction_handling.set}
  set onSecondaryTap(_EventCallback onSecondaryTap) =>
      _manageEventSubscription(WinEvent.contextMenu, onSecondaryTap);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onSecondaryTap => _callbacks[WinEvent.contextMenu];

  /// {@macro betrayal.interaction_handling.set}
  set onTapDown(_EventCallback onTapDown) =>
      _manageEventSubscription(WinEvent.leftButtonDown, onTapDown);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onTapDown => _callbacks[WinEvent.leftButtonDown];

  /// {@macro betrayal.interaction_handling.set}
  set onSecondaryTapDown(_EventCallback onSecondaryTapDown) =>
      _manageEventSubscription(WinEvent.rightButtonDown, onSecondaryTapDown);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onSecondaryTapDown => _callbacks[WinEvent.rightButtonDown];

  /// {@macro betrayal.interaction_handling.set}
  set onTertiaryTapDown(_EventCallback onTertiaryTapDown) =>
      _manageEventSubscription(WinEvent.middleButtonDown, onTertiaryTapDown);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onTertiaryTapDown => _callbacks[WinEvent.middleButtonDown];

  /// {@macro betrayal.interaction_handling.set}
  set onTapUp(_EventCallback onTapUp) =>
      _manageEventSubscription(WinEvent.leftButtonUp, onTapUp);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onTapUp => _callbacks[WinEvent.leftButtonUp];

  /// {@macro betrayal.interaction_handling.set}
  set onSecondaryTapUp(_EventCallback onSecondaryTapUp) =>
      _manageEventSubscription(WinEvent.rightButtonUp, onSecondaryTapUp);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onSecondaryTapUp => _callbacks[WinEvent.rightButtonUp];

  /// {@macro betrayal.interaction_handling.set}
  set onTertiaryTapUp(_EventCallback onTertiaryTapUp) =>
      _manageEventSubscription(WinEvent.middleButtonUp, onTertiaryTapUp);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onTertiaryTapUp => _callbacks[WinEvent.middleButtonUp];

  /// {@macro betrayal.interaction_handling.set}
  set onDoubleTap(_EventCallback onDoubleTap) =>
      _manageEventSubscription(WinEvent.select, onDoubleTap);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onDoubleTap => _callbacks[WinEvent.select];

  /// {@macro betrayal.interaction_handling.set}
  set onSecondaryDoubleTap(_EventCallback onSecondaryDoubleTap) =>
      _manageEventSubscription(
          WinEvent.rightButtonDoubleClick, onSecondaryDoubleTap);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onSecondaryDoubleTap =>
      _callbacks[WinEvent.rightButtonDoubleClick];

  /// {@macro betrayal.interaction_handling.set}
  set onTertiaryDoubleTap(_EventCallback onTertiaryDoubleTap) =>
      _manageEventSubscription(
          WinEvent.middleButtonDoubleClick, onSecondaryDoubleTap);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onTertiaryDoubleTap =>
      _callbacks[WinEvent.middleButtonDoubleClick];

  /// {@macro betrayal.interaction_handling.set}
  set onPointerMove(_EventCallback onPointerMove) =>
      _manageEventSubscription(WinEvent.mouseMove, onPointerMove);

  /// {@macro betrayal.interaction_handling.get}
  _EventCallback get onPointerMove => _callbacks[WinEvent.mouseMove];

  set _callbacks(Map<WinEvent, _EventCallback> _callbacks) {
    _callbacks.forEach(_manageEventSubscription);
  }

  Map<WinEvent, _EventCallback> get _callbacks => __callbacks;

  void _manageEventSubscription(WinEvent event, _EventCallback callback) {
    final oldCallback = __callbacks[event];
    if (callback == oldCallback) return;
    if (callback != null && oldCallback == null) {
      _logger.fine("subscribing to ${event.name}");
      TrayIcon._plugin.subscribeTo(_id, event);
    } else if (callback == null && oldCallback != null) {
      _logger.fine("unsubscribing from ${event.name}");
      TrayIcon._plugin.unsubscribeFrom(_id, event);
    }
    __callbacks[event] = callback;
    return;
  }

  void _handleInteraction(_TrayIconInteraction interaction) {
    _logger.finer("received interaction: $interaction");
    _callbacks[interaction.event]?.call(interaction.position);
  }
}
