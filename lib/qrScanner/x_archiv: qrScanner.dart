import 'package:FridgerApp/helpers/provider.dart';
import 'package:FridgerApp/inventory/productData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
   DateTime _dateTime;
     String scannedItem = "–";

    @override
  Widget build(BuildContext context) {
  final fridge = Provider.of<Fridge>(context); // consumer for fridge
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        // consumer
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Scan:",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              scannedItem,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                // QR or Barcode Scanner
                String codeSanner = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
                // remove setState --> object.item(method)
                setState(() {
                  scannedItem = codeSanner;
                });
              },
              child: Text(
                "Produkt scannen",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0)),
            ),

            
            SizedBox(height: 45.0),
            // date picker

            Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
            RaisedButton(
              child: Text('Pick a date'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2031)
                ).then((pickedDate) {
                  setState(() {
                     _dateTime = pickedDate;
                  });
                });
              },
            ),

            SizedBox(height: 45.0),

            // add scanned product
            FlatButton(
              onPressed: () => fridge.addItem(
                ProductData(
                    text: scannedItem, mhd: DateFormat('dd.MM.yyyy').format(_dateTime)),
              ),
              child: Text("Add scanned product"),
            ),


          ],
        ),
      ),
    );
  }
}
