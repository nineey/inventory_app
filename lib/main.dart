import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/changeNotifier.dart';
import 'scaffold/app.dart';

main() {
  runApp(
    // top of application tree – provider for all changes on
    ChangeNotifierProvider(
      create: (context) => Fridge(),
      child: InventoryApp(),
    ),
  );
}
