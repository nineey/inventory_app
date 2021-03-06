import 'package:FridgerApp/helpers/changeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbar.dart';

class InventoryApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    // consumer
    final fridge = Provider.of<Fridge>(context);

    return MaterialApp(
      title: 'Fridger',
      theme: ThemeData(
        // UI color is set by editable variable "uiColor" (helpers/changeNotifier.dart)
        primarySwatch: fridge.uiColor,
      ),
      home: Navbar(),
    );
  }
}
