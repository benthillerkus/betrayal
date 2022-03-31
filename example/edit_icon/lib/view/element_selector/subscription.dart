import 'delegate.dart';

class ElementSelectorDelegateSubscription {
  ElementSelectorDelegateSubscription(
      {this.onAdd, this.onRemove, required this.delegate});
  Function? onAdd;
  Function(int index)? onRemove;
  ElementSelectorDelegate delegate;

  void unsubscribe() {
    onAdd = null;
    onRemove = null;
    delegate.removeSubscription(this);
  }
}
