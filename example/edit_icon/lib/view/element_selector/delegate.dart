import 'data.dart';
import 'subscription.dart';

class ElementSelectorDelegate {
  ElementSelectorDelegate({Iterable<ElementSelectorData>? initialItems}) {
    _items = initialItems?.toList() ?? <ElementSelectorData>[];
  }

  late final List<ElementSelectorData> _items;
  get numItems => _items.length;
  final List<ElementSelectorDelegateSubscription> _subscriptions = [];

  void add(ElementSelectorData item) async {
    _items.add(item);
    for (var sub in _subscriptions) {
      if (sub.onAdd != null) await sub.onAdd!();
    }
  }

  Future<void> removeAt(int index) async {
    _items.removeAt(index);
    for (var sub in _subscriptions) {
      if (sub.onRemove != null) await sub.onRemove!(index);
    }
  }

  ElementSelectorDelegateSubscription subscribe(
      {Function? onAdd, Function(int index)? onRemove}) {
    var sub = ElementSelectorDelegateSubscription(
        onAdd: onAdd, onRemove: onRemove, delegate: this);
    _subscriptions.add(sub);
    return sub;
  }

  void removeSubscription(ElementSelectorDelegateSubscription sub) {
    _subscriptions.remove(sub);
  }

  ElementSelectorData elementAt(int index) => _items.elementAt(index);
}