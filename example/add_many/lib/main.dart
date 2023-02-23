import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:betrayal/betrayal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  // This is only necessary if icons seem to persist after hot restarting.
  // That happens when after restarting the app is not immediately interacting
  // with [TrayIcon]s again.
  if (kDebugMode) TrayIcon.clearAll();
  runApp(const MyApp());
}

class DebugGraphic extends CustomPainter {
  int count;
  DebugGraphic(this.count);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);
    final Paint paint = Paint()..color = const Color(0xFFF400BB);
    canvas.drawRect(Rect.fromLTWH(0, 0, center.dx, center.dy), paint);
    canvas.drawRect(Rect.fromLTWH(center.dx, 0, center.dx, center.dy),
        paint..color = Colors.green);
    canvas.drawRect(Rect.fromLTWH(0, center.dy, center.dx, center.dy),
        paint..color = Colors.blue);
    canvas.drawCircle(center, sqrt(count),
        paint..color = const Color.fromARGB(255, 211, 168, 202));
    TextPainter(
        text: TextSpan(text: "$count"),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        maxLines: 1)
      ..layout()
      ..paint(canvas, Offset.zero);
    canvas.drawRect(
        const Rect.fromLTWH(1, 0, 1, 1), paint..color = Colors.green);
    canvas.drawRect(
        const Rect.fromLTWH(2, 0, 1, 1), paint..color = Colors.blue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _icons = List<TrayIcon>.empty(growable: true);

  ui.Image? img;

  void add() async {
    var icon = TrayIcon();
    _icons.add(icon);
    icon.setTooltip("${_icons.length}");

    await draw(size: TrayIcon.preferredImageSize);

    setState(() {});

    icon.setImage(
      pixels:
          (await img?.toByteData(format: ui.ImageByteFormat.rawRgba))?.buffer,
      // asset: "assets/flutter.ico",
      // winIcon: WinIcon.shield
    );
    icon.show();
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
          title: const Center(child: Text('draw canvas into tray example')),
        ),
        body: Stack(
          children: [
            Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: _icons.isEmpty ? 0 : sqrt(sqrt(_icons.length + 1)),
                curve: Curves.easeOutBack,
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CustomPaint(
                    painter: DebugGraphic(_icons.length),
                  ),
                ),
              ),
            ),
            Opacity(
              opacity: .4,
              child: GridView.builder(
                itemCount: max(0, _icons.length - 1),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 32 + 16),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Tooltip(
                    message: "${index + 1}", // There is no 0th item
                    child: CustomPaint(
                      painter: DebugGraphic(index + 1),
                    ),
                  ),
                ),
              ),
            )
          ],
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

  Future<void> draw({Size size = const Size(32, 32)}) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    DebugGraphic(_icons.length).paint(canvas, size);
    final picture = recorder.endRecording();

    img = await picture.toImage(size.width.toInt(), size.height.toInt());
  }

  void remove() async {
    _icons.removeLast().dispose();
    await draw();
    setState(() {});
  }

  void removeAll() async {
    TrayIcon.clearAll();
    _icons.clear();
    await draw();
    setState(() {});
  }
}
