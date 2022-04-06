import 'data.dart';
import 'subscription.dart';

class ElementSelectorDelegate<DataType extends ElementSelectorData> {
  ElementSelectorDelegate(
      {Iterable<DataType>? initialItems,
      this.onEmptied,
      this.onElementChanged}) {
    _items = initialItems?.toList() ?? <DataType>[];
  }

  late final List<DataType> _items;
  get numItems => _items.length;

  /// Called after the final element is removed
  final void Function()? onEmptied;

  /// Called when the element is changed.
  final void Function(DataType element)? onElementChanged;
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

  Future<void> replaceAt(int index, DataType item) async {
    _items[index] = item;
    for (var sub in _subscriptions) {
      if (sub.onReplace != null) await sub.onReplace!(index);
    }
    if (onElementChanged != null) onElementChanged!(item);
  }

  ElementSelectorDelegateSubscription subscribe(
      {Function? onAdd,
      Function(int index)? onRemove,
      Function(int index)? onReplace}) {
    var sub = ElementSelectorDelegateSubscription(
        onAdd: onAdd, onRemove: onRemove, onReplace: onReplace, delegate: this);
    _subscriptions.add(sub);
    return sub;
  }

  void removeSubscription(ElementSelectorDelegateSubscription sub) {
    _subscriptions.remove(sub);
  }

  DataType elementAt(int index) => _items.elementAt(index);
}
