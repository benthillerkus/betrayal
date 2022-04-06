import 'data.dart';
import 'subscription.dart';

class ElementSelectorDelegate<DataType extends ElementSelectorData> {
  ElementSelectorDelegate({Iterable<DataType>? initialItems, this.onEmptied}) {
    _items = initialItems?.toList() ?? <DataType>[];
  }

  late final List<DataType> _items;
  get numItems => _items.length;
  final void Function()? onEmptied;
  final List<ElementSelectorDelegateSubscription> _subscriptions = [];

  void add(DataType item) async {
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
    if (_items.isEmpty) onEmptied?.call();
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

  DataType elementAt(int index) => _items.elementAt(index);
}
