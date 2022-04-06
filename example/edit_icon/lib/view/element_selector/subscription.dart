import 'delegate.dart';

class ElementSelectorDelegateSubscription {
  ElementSelectorDelegateSubscription(
      {this.onAdd, this.onRemove, this.onReplace, required this.delegate});
  Function? onAdd;
  Function(int index)? onRemove;
  Function(int index)? onReplace;
  ElementSelectorDelegate delegate;

  void unsubscribe() {
    onAdd = null;
    onRemove = null;
    onReplace = null;
    delegate.removeSubscription(this);
  }
}
