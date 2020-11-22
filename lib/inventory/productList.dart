import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:FridgerApp/helpers/provider.dart';

import 'productDetail.dart';

class InventoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // consumer
    final fridge = Provider.of<Fridge>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kühlschrank von ' + fridge.username),
      ),
      body: Center(
        // building list view with card layout
        child: ListView.builder(
          itemCount: fridge.items.length,
          itemBuilder: (context, index) {
            var item = fridge.items[index];

            return Card(
              child: ListTile(
                title: Text(item.text),
                subtitle: Text(
                  item.mhd,
                ),
                trailing: Text('Stück: ' + item.quantity.toString()),
                // navigate to detail page on tab
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(item)),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
