import 'package:FridgerApp/helpers/changeNotifier.dart';
import 'package:FridgerApp/helpers/productData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // Local variables
  DateTime _dateTime;
  int tempQuantity = 1;
  String error = "";

  @override
  Widget build(BuildContext context) {
    // Consumer
    final fridge = Provider.of<Fridge>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Produkt hinzufügen"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Show the scanned item
            Text(
              "Produkt",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              fridge.scannedItem,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 50.0),

            // Section for user entry of the quantity
            Text(
              "Menge",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Row of buttons to edit quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Button for local var of quantity +1
                FlatButton(
                  onPressed: () {
                    setState(() {
                      tempQuantity++;
                    });
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

                // Show integer for quantity
                Text(
                  "$tempQuantity",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Button for local var of quantity -1
                FlatButton(
                  onPressed: () {
                    if (tempQuantity > 1) {
                      setState(() {
                        tempQuantity--;
                      });
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

            SizedBox(height: 50.0),

            // Date picker
            Text(
              "Datum",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              _dateTime == null
                  ? '–'
                  // Format the date into swiss style (using package intl.dart)
                  : DateFormat('dd.MM.yyyy').format(_dateTime),
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: fridge.uiColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text('Datum wählen'),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2031))
                    .then((pickedDate) {
                  setState(() {
                    _dateTime = pickedDate;
                    // Remove error message if date picked
                    error = "";
                  });
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.all(40.0),
              // Text only visible if error occurs
              child: Text('$error', style: TextStyle(color: Colors.red)),
            ),

            // Section to add and save scanned product
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FlatButton(
                  padding: EdgeInsets.all(30),
                  color: fridge.uiColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {
                    // Show error message of no date is picked
                    if (_dateTime == null) {
                      setState(() {
                        error = "Bitte ein Datum wählen";
                      });
                      // If all data is set, add product to inventory list
                    } else {
                      fridge.addItem(ProductData(
                          name: fridge.scannedItem,
                          mhd: DateFormat('dd.MM.yyyy').format(_dateTime),
                          quantity: this.tempQuantity));
                      // Navigate back to scanner page
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Hinzufügen", style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
