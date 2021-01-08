import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:FridgerApp/helpers/changeNotifier.dart';

import 'productDetail.dart';

class InventoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Consumer
    final fridge = Provider.of<Fridge>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kühlschrank von ' + fridge.username),
      ),
      body: Center(
        // Building list view with card layout
        child: ListView.builder(
            itemCount: fridge.items.length,
            itemBuilder: (context, index) {
              var item = fridge.items[index];
              if (fridge.items.length >= 1) {
                return Card(
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text(
                      item.mhd,
                    ),
                    trailing: Text('Stück: ' + item.quantity.toString()),
                    // Navigate to detail page on tab
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetail(item)),
                      );
                    },
                  ),
                );
              }
              // Return error message, if product list is empty
              else {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Keine Produkte vorhanden."),
                );
              }
            }),
      ),
    );
  }
}
