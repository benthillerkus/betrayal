import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({Key? key}) : super(key: key);

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${args["item"].id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(64),
        child: Center(
          child: TextField(
            decoration: const InputDecoration(labelText: "Set tooltip…"),
            onChanged: (value) => args["icon"].setTooltip(value),
          ),
        ),
      ),
    );
  }
}
