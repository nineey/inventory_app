import 'package:FridgerApp/helpers/changeNotifier.dart';
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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(20.0),
                onPressed: () async {
                  // Open QR Scanner on button pressed
                  // Save scanned data into variable "scannedItem" of provider
                  String codeSanner = await FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Cancel", true, ScanMode.QR);
                  setState(() {
                    fridge.scannedItem = codeSanner;
                  });
                  // Redirect to page 'addProduct' after scanning
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddProductPage(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.camera, color: fridge.uiColor, size: 50.0),
                    SizedBox(height: 10.0),
                    Text(
                      "Produkt scannen",
                      style: TextStyle(
                          color: fridge.uiColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: fridge.uiColor, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
              ),

              SizedBox(height: 20.0),

              // Button for testing purpose (no camera on emulator)
              // Redirects to page "addProduct" with var scannedItem = "MockItem"
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddProductPage(),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text("TestItem hinzufügen",
                    style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
