// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:io';

import 'package:betrayal/betrayal.dart';
import 'package:edit_icon/view/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betrayal Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 199, 184, 116),
              brightness: Brightness.light)),
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 199, 184, 116),
              brightness: Brightness.dark)),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class MyData extends ElementSelectorData {
  MyData({Widget? Function(BuildContext)? builder, Key? key, this.name})
      : super(builder: builder, key: key);

  final String? name;
}

class _HomeScreenState extends State<HomeScreen> {
  late final TrayIcon _icon = TrayIcon(const TrayIconData());

  @override
  void dispose() {
    _icon.dispose();
    super.dispose();
  }

  final _delegate = ElementSelectorDelegate(initialItems: [
    MyData(name: "A", builder: (_) => const FlutterLogo()),
    MyData(name: "B", builder: (_) => const FlutterLogo()),
    MyData(builder: (_) => const FlutterLogo()),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElementSelector(
      axis: Axis.vertical,
      onSelectionChanged: (index) {
        final element = _delegate.elementAt(index);

        _icon.setTooltip(element.name ?? element.key.toString());
        _icon.setIcon();
        _icon.show();
      },
      addTooltip: "Add new Image",
      delegate: _delegate,
      onAddPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: const ["ico", "png"]);
        if (result == null) return;
        final path = result.files.first.path!;
        _delegate.add(MyData(builder: (_) => Image.file(File(path))));
      },
    ));
  }
}
