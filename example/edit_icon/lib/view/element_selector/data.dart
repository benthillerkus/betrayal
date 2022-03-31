import 'package:flutter/widgets.dart';

class ElementSelectorData {
  ElementSelectorData(this.widget, {Key? key}) {
    this.key = key ?? GlobalKey();
  }

  final Function(BuildContext) widget;
  late final Key key;
}
