// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:io';

import 'package:betrayal/betrayal.dart';
import 'package:edit_icon/view/view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

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
  MyData(
      {Widget? Function(BuildContext)? builder,
      Key? key,
      String? name,
      required this.delegate})
      : super(builder: builder, key: key, name: name);

  TrayIconImageDelegate delegate;
}

class _HomeScreenState extends State<HomeScreen> {
  late final TrayIcon _icon = TrayIcon(const TrayIconData());

  @override
  void initState() {
    super.initState();
    _setTrayIcon(_delegate.elementAt(0));
  }

  @override
  void dispose() {
    _icon.dispose();
    super.dispose();
  }

  void _setTrayIcon(MyData element) {
    _icon.setTooltip(element.name ?? element.key.toString());
    _icon.setIcon(delegate: element.delegate);
    _icon.show();
  }

  final _delegate = ElementSelectorDelegate(initialItems: [
    MyData(
        name: "Dart",
        delegate: TrayIconImageDelegate.fromAsset("assets/dart.ico"),
        builder: (_) => Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Dart-logo.png/600px-Dart-logo.png")),
    MyData(
        name: "Question",
        delegate: TrayIconImageDelegate.fromWinIcon(WinIcon.question),
        builder: (_) => Image.network(
            "https://www.clipartmax.com/png/middle/149-1499106_question-mark-animation-clip-art-question-mark-animation.png")),
    MyData(
        delegate: TrayIconImageDelegate.fromAsset("assets/flutter.ico"),
        builder: (_) => const FlutterLogo(),
        name: "Flutter"),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElementSelector(
      axis: Axis.vertical,
      onSelectionChanged: (index) {
        final element = _delegate.elementAt(index);
        _setTrayIcon(element);
      },
      addTooltip: "Add new Image",
      dimension: 150,
      gap: 24,
      delegate: _delegate,
      onAddPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: const ["ico", "png"]);
        if (result == null) return;
        final file = result.files.first;
        final path = file.path!;

        late TrayIconImageDelegate iconSource;
        switch (file.extension) {
          case "ico":
            iconSource = TrayIconImageDelegate.fromPath(path: path);
            break;
          case "png":
            var resized = await compute((String path) {
              var org = img.decodePng(File(path).readAsBytesSync());
              var resized = img.copyResizeCropSquare(org!, 32);
              return resized.getBytes().buffer;
            }, path);

            iconSource = TrayIconImageDelegate.fromBytes(resized);
            break;
        }

        _delegate.add(MyData(
            delegate: iconSource, builder: (_) => Image.file(File(path))));
      },
    ));
  }
}
