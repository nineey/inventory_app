import 'package:FridgerApp/helpers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navbar.dart';

class InventoryApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    final fridge = Provider.of<Fridge>(context); // consumer

    return MaterialApp(
      title: 'Fridger',
      theme: ThemeData(
        primarySwatch: fridge.uiColor,
      ),
      home: Navbar(),
    );
  }
}
