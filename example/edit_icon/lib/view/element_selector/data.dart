import 'package:flutter/widgets.dart';

class ElementSelectorData {
  ElementSelectorData({Widget? Function(BuildContext)? builder, Key? key}) {
    this.key = key ?? GlobalKey();
    this.builder = builder ?? (BuildContext context) => null;
  }

  late final Widget? Function(BuildContext) builder;
  late final Key key;
}
