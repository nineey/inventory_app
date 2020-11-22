import 'package:FridgerApp/helpers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'addProduct.dart';

class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  @override
  Widget build(BuildContext context) {
    // consumer
    final fridge = Provider.of<Fridge>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                // open QR Scanner on button pressed
                // save scanned data into variable "scannedItem" of provider
                String codeSanner = await FlutterBarcodeScanner.scanBarcode(
                    "#ff6666", "Cancel", true, ScanMode.QR);
                setState(() {
                  fridge.scannedItem = codeSanner;
                });
                // redirect to page 'addProduct' after scanning
                // --> INVESTIGATE: how to NOT push when scanner is canceled by user without scanning
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              child: Text(
                "Produkt scannen",
                style: TextStyle(
                    color: fridge.uiColor, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: fridge.uiColor, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0)),
            ),

            SizedBox(height: 50.0),

            // button for testing purpose (no camera on emulator) -> open page "addProduct"
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProductPage()));
              },
              child: Text("click for testing"),
            ),
          ],
        ),
      ),
    );
  }
}
