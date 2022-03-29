import 'package:betrayal/betrayal.dart';
import 'package:flutter/widgets.dart';

class TrayIconWidget extends StatefulWidget {
  final TrayIconData data;

  const TrayIconWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<TrayIconWidget> createState() => _TrayIconWidgetState();
}

class _TrayIconWidgetState extends State<TrayIconWidget> {
  late final TrayIcon _trayIcon;

  @override
  void initState() async {
    super.initState();
    _trayIcon = TrayIcon(widget.data);
    _trayIcon.show();
  }

  @override
  void dispose() {
    _trayIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
