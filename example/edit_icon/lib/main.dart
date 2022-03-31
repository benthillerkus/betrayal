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

class _HomeScreenState extends State<HomeScreen> {
  late final TrayIcon _icon = TrayIcon(const TrayIconData());

  @override
  void dispose() {
    _icon.dispose();
    super.dispose();
  }

  final _items = [
    ElementSelectorData((_) => const FlutterLogo()),
    ElementSelectorData((_) => const FlutterLogo()),
    ElementSelectorData((_) => const FlutterLogo()),
  ];

  late final _delegate = ElementSelectorDelegate(initialItems: _items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElementSelector(
      axis: Axis.vertical,
      onSelectionChanged: (index) {
        _icon.setTooltip(_delegate.elementAt(index).key.toString());
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
        _delegate.add(ElementSelectorData((_) => Image.file(File(path))));
      },
    ));
  }
}
