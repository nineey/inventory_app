import 'package:flutter/material.dart';
import 'package:FridgerApp/helpers/productData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


      

class Fridge extends ChangeNotifier {

   Fridge() {
     // get saved username and uiColor from shared prefs
    var prefs = SharedPreferences.getInstance();
    prefs.then((p) {
      this.username = p.get("username") ?? "{Dein Name}";
      this.uiColor = colors[p.get("uiColor")] ?? Colors.green;
      notifyListeners();
    });
      // connect to DB and update item list
      openDB().then((db) {
      updateItemList();
    });
  }

  // global variables which are used on multiple pages
  String username = "";
  String scannedItem = "MockItem"; // MockItem is used for testing button
  // current UI Color
  var uiColor;
  // map to transform String "color" to Material-Color
  Map<String, MaterialColor> colors = {
    "blue" : Colors.blue,
    "green" : Colors.green,
    "grey" : Colors.grey,
  };
  Future<Database> database;
  List<ProductData> items = [];
  
  // Open database and create table if not existing
  Future<Database> openDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    database = openDatabase(
      // Set the path to the database
      join(await getDatabasesPath(), 'fridger.db'),
      // When the database is first created, create a table to store products
      onCreate: (db, version) {
        db.execute("CREATE TABLE products(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, mhd TEXT, quantity INTEGER)");
      },
      version: 1,
    );
    return database;
  }


  // get database and transform data map into list of objects
  void updateItemList() async {
    final Database db = await database;

    // Query the table for all products
    final List<Map<String, dynamic>> maps = await db.query('products');

    //Convert the List<Map<String, dynamic> into a List<ProductData>.
    items = List.generate(maps.length, (i) {
      return ProductData(
        id: maps[i]['id'],
        name: maps[i]['name'],
        mhd: maps[i]['mhd'],
        quantity: maps[i]['quantity'],
      );
    });

    notifyListeners();
  }

  void updateItem(item) async{
    // get a reference to the database
    final Database db = await database;

    // update the given product
    await db.update(
      'products',
      item.toMap(),
      // ensure that the product has a matching id
      where: "id = ?",
      // Pass the product's ID as a whereArg to prevent SQL injection
      whereArgs: [item.id],
    );
    // call function to update the list view
    updateItemList();
  }


   // function: Add item to list
  void addItem(ProductData item) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the product into the table
    await db.insert(
      'products',
      // call function 'toMap' from class ProductData: transform map out of product data
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    updateItemList();
  }

  // function: quantity of a single product +1
  void plus(ProductData item) async{
    item.quantity++;
    updateItem(item);
  }

  // function: remove item from list and database
  void deleteItem(item) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.delete(
      'products',
      // Use a `where` clause to delete a specific product.
      where: "id = ?",
      // Pass the product's id as a whereArg to prevent SQL injection.
      whereArgs: [item.id],
    );
    updateItemList();

  }

  // function: quantity of a single product -1
   void minus(ProductData item) async {
     item.quantity--;
     updateItem(item);
  }

  // function: change expiry date
  void changeDate(ProductData item, newDate) async{
    item.mhd = newDate.toString();
    updateItem(item);
  }

  // function: set a username in settings
  void setName(text) {
    this.username = text;
    var prefs = SharedPreferences.getInstance();
    // save username 
    prefs.then((p) {
      p.setString("username", text);
    });
    notifyListeners();
  }

// function: changes color of UI
void changeColor(color) {
  if(color == "blue"){
    this.uiColor = Colors.blue;
  }
  if(color == "green"){
    this.uiColor = Colors.green;
  }
  if(color == "grey"){
    this.uiColor = Colors.grey;
  }

  var prefs = SharedPreferences.getInstance();
  prefs.then((p) {
    p.setString("uiColor", color);
  });

  notifyListeners();
}

} // end of class