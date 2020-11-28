import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/provider.dart';
import 'scaffold/app.dart';

main() {
  runApp(
    // top of application tree – provider for all changes on
    // INVESTIGATE: argument "create" required? 
    ChangeNotifierProvider(
      create: (context) => Fridge(),
      child: InventoryApp()
    )
  );
}
