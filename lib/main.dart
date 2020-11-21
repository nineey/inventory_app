import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helpers/provider.dart';
import 'scaffold/app.dart';

main() {
  runApp(
    // provider for all changes
    ChangeNotifierProvider(
      builder: (context) => Fridge(),
      child: InventoryApp()
    )
  );
}
