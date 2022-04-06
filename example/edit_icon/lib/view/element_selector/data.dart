import 'package:flutter/widgets.dart';

class ElementSelectorData {
  ElementSelectorData(
      {Widget? Function(BuildContext context)? builder, Key? key, this.name}) {
    this.key = key ?? GlobalKey();
    this.builder = builder ?? (BuildContext context) => null;
  }

  late final Widget? Function(BuildContext) builder;
  late final Key key;
  final String? name;

  ElementSelectorData copyWith(
          {Widget? Function(BuildContext context)? builder,
          String? name,
          Key? key}) =>
      ElementSelectorData(
          builder: builder ?? this.builder,
          name: name ?? this.name,
          key: key ?? this.key);
}
