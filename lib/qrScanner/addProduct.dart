import 'package:FridgerApp/helpers/provider.dart';
import 'package:FridgerApp/inventory/productData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  DateTime _dateTime;
  int tempQuantity = 1;
  String error = "";

  @override
  Widget build(BuildContext context) {
    final fridge = Provider.of<Fridge>(context); // consumer for fridge

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
            // show the scanned item
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

            // input quantity
            Text(
              "Menge",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // row of buttons to edit quantity
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // button for quantity +1

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

                // int for quantity
                Text(
                  "$tempQuantity",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),

                // button for quantity -1
                FlatButton(
                  onPressed: () {
                    if(tempQuantity > 1){
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

            // date picker
            Text(
              "Datum",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              _dateTime == null
                  ? '–'
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
                    error = "";
                  });
                });
              },
            ),

            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text('$error', style: TextStyle(color: Colors.red)),
            ),

            // add scanned product
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
                    if(_dateTime == null){
                      setState(() {
                        error = "Bitte ein Datum wählen";
                      });
                    }
                    else {
                    fridge.addItem(ProductData(
                        text: fridge.scannedItem,
                        mhd: DateFormat('dd.MM.yyyy').format(_dateTime),
                        quantity: this.tempQuantity));
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
