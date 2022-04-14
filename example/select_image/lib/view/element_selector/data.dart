import 'package:flutter/widgets.dart';

class SelectableData {
  SelectableData(
      {Widget? Function(BuildContext context)? builder, Key? key, this.name}) {
    this.key = key ?? GlobalKey();
    this.builder = builder ?? (BuildContext context) => null;
  }

  late final Widget? Function(BuildContext) builder;
  late final Key key;
  final String? name;

  SelectableData copyWith(
          {Widget? Function(BuildContext context)? builder,
          String? name,
          Key? key}) =>
      SelectableData(
          builder: builder ?? this.builder,
          name: name ?? this.name,
          key: key ?? this.key);
}
