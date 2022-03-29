import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:betrayal/betrayal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  final _icons = List<TrayIcon>.empty(growable: true);

  ui.Image? img;

  void add() async {
    var icon = TrayIcon(const TrayIconData());
    _icons.add(icon);
    icon.setTooltip("${_icons.length}");

    await draw();

    setState(() {});

    icon.setIcon(
        image: img,
        // picture: picture,
        // asset: "assets/flutter.ico",
        freeResources: false,
        winIcon: WinIcon.shield);
    icon.show();
  }

  Future<void> draw() async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    const center = Offset(16, 16);
    final Paint paint = Paint()..color = const Color(0xFFF400BB);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 16, 16), paint);
    canvas.drawRect(
        const Rect.fromLTWH(16, 0, 16, 16), paint..color = Colors.green);
    canvas.drawRect(
        const Rect.fromLTWH(0, 16, 16, 16), paint..color = Colors.blue);
    canvas.drawCircle(center, sqrt(_icons.length.ceilToDouble()),
        paint..color = const Color.fromARGB(255, 211, 168, 202));
    TextPainter(
        text: TextSpan(text: "${_icons.length}"),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 1)
      ..layout()
      ..paint(canvas, Offset.zero);
    canvas.drawRect(
        const Rect.fromLTWH(1, 0, 1, 1), paint..color = Colors.green);
    canvas.drawRect(
        const Rect.fromLTWH(2, 0, 1, 1), paint..color = Colors.blue);

    final picture = recorder.endRecording();

    img = await picture.toImage(32, 32);
  }

  void remove() async {
    _icons.removeLast().dispose();
    await draw();
    setState(() {});
  }

  void removeAll() async {
    for (var icon in _icons) {
      icon.dispose();
    }
    _icons.clear();
    await draw();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: Colors.lime,
          useMaterial3: true,
          brightness: Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Imperative System Tray Api Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: img == null
                    ? null
                    : CustomPaint(
                        painter: Lol(img!),
                      ),
                width: 32,
                height: 32,
              ),
              const Text('Number of Icons:'),
              SizedBox.fromSize(
                size: const Size.fromHeight(20),
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: sqrt(sqrt(_icons.length + 1)),
                  curve: Curves.easeOutBack,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: BoxShape.circle),
                    child: Transform.translate(
                      offset: const Offset(0, -2),
                      child: Center(
                          child: Text(
                        '${_icons.length}',
                        style: Theme.of(context).textTheme.headline4,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          TextButton.icon(
              onPressed: add,
              icon: const Icon(Icons.plus_one),
              label: const Text("Add Icon")),
          TextButton.icon(
              onPressed: _icons.isEmpty ? null : remove,
              icon: const Icon(Icons.remove),
              label: const Text("Remove Icon"),
              onLongPress: _icons.isEmpty ? null : removeAll),
        ],
      ),
    );
  }
}

class Lol extends CustomPainter {
  Lol(this.img);

  ui.Image img;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawImage(img, Offset.zero, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
