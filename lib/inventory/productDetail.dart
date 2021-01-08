import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:FridgerApp/helpers/changeNotifier.dart';
import '../helpers/productData.dart';

// Detail page for elements in the products list
// Opens by tab on list tile
// Also used to edit product data
class ProductDetail extends StatefulWidget {
  final ProductData item;

  ProductDetail(this.item);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    // Consumer
    final fridge = Provider.of<Fridge>(context);

    // Local variables
    DateTime _dateTime;

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(widget.item.name,
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

              SizedBox(height: 20),

              // Expiry date
              Text("Mindestens haltbar bis:",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Text(widget.item.mhd, style: TextStyle(fontSize: 20.0)),

              // Button to edit date
              // Opens the date picker
              FlatButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: fridge.uiColor, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text('Datum ändern'),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              _dateTime == null ? DateTime.now() : _dateTime,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2031))
                      .then((pickedDate) {
                    fridge.changeDate(
                        widget.item,
                        // Format the date into swiss style (using package intl.dart)
                        DateFormat('dd.MM.yyyy').format(pickedDate));
                  });
                },
              ),

              SizedBox(height: 20),

              Text("Menge", style: TextStyle(fontWeight: FontWeight.bold)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Button for quantity +1
                  // Calls function 'plus' on "changeNotifier.dart"
                  FlatButton(
                    onPressed: () {
                      fridge.plus(widget.item);
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(8),
                    shape: CircleBorder(),
                  ),

                  // Shows int "quantity"
                  Text(widget.item.quantity.toString(),
                      style: TextStyle(fontSize: 20.0)),

                  // Button for quantity -1
                  // Calls function 'minus' on "changeNotifier.dart"
                  FlatButton(
                    onPressed: () {
                      if (widget.item.quantity > 1) {
                        fridge.minus(widget.item);
                      }
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.remove,
                      size: 24,
                    ),
                    padding: EdgeInsets.all(8),
                    shape: CircleBorder(),
                  ),
                ],
              ),

              // Button to remove item completely from list
              // Calls function 'deleteItem' on "changeNotifier.dart"
              Padding(
                padding: EdgeInsets.fromLTRB(0, 250.0, 0, 0),
                child: FlatButton(
                    onPressed: () {
                      fridge.deleteItem(widget.item);
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 50.0,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
