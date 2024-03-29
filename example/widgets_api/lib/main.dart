import 'package:betrayal/betrayal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  // Configure plugin log levels
  BetrayalLogConfig.allowIndividualLevels();
  BetrayalLogConfig.level = kDebugMode ? "FINER" : "INFO";

  // This is only necessary if icons seem to persist after hot restarting.
  // That happens when after restarting the app is not immediately interacting
  // with [TrayIcon]s again.
  if (kDebugMode) TrayIcon.clearAll();
  // Try commenting this out and then restart the app.
  // Then set [inserted] in [_MyHomePageState] to `true`.
  // Now the app will immediately need a new [TrayIcon]
  // and the old one can be removed.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betrayal Widgets API Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// `true` when a [TrayIcon] has been added to the tray.
  bool inserted = false;

  /// `false` if the [TrayIcon] is hidden.
  bool shown = true;
  String tooltip = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            tooltip: inserted ? "Remove from tray" : "Add to tray",
            icon: Icon(inserted ? Icons.remove : Icons.add),
            onPressed: () => setState(() => inserted = !inserted)),
        backgroundColor: shown ? Colors.amber : Colors.blueAccent,
        title: TextField(
          decoration: const InputDecoration(
            isDense: false,
            hintText: 'Enter tooltip here...',
          ),
          onChanged: (value) => setState(() => tooltip = value),
        ),
      ),
      body: inserted
          ? Material(
              color: shown ? Colors.amberAccent : Colors.blue,
              child: TrayIconWidget(
                  visible: shown,
                  tooltip: tooltip,
                  child: InkWell(
                    onTap: () => setState(
                      () => shown = !shown,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                              child: Text(
                            shown ? "Hide" : "Show",
                            style: Theme.of(context).textTheme.displayLarge,
                          )),
                        ),
                        AnimatedOpacity(
                          opacity: shown ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 32),
                            child: SizedBox(
                              height: 75,
                              child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(dragDevices: {
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.mouse
                                }, scrollbars: true),
                                child: ListView.builder(
                                  itemExtent: 75,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: StockIcon.values.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final icon = StockIcon.values[index];
                                    return IconButton(
                                        tooltip: "Set the ${icon.name} icon",
                                        onPressed: shown
                                            ? () => TrayIcon.of(context)
                                                .setImage(stockIcon: icon)
                                            : null,
                                        icon: Text(icon.emoji));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Press the 'Add to tray' button to add an icon to the system tray.",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
    );
  }
}
