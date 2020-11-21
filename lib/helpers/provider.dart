import 'package:flutter/material.dart';
import 'package:FridgerApp/inventory/productData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Fridge extends ChangeNotifier {
  
   Fridge() {
     //get saved username from shared prefs
    var prefs = SharedPreferences.getInstance();
     // Future - wait
    prefs.then((p) {
        this.username = p.get("username") ?? "{Dein Name}";
        notifyListeners();
      });
  }

  // global variables which are used on multiple pages
  String username;
  var uiColor = Colors.green;
  String scannedItem = "MockItem";


  // list of products for testing
  // --> investigate how to save data into database / shared prefs
  List<ProductData> items = [
    ProductData(text: 'Eier', mhd: '30.10.2020', quantity: 1),
    ProductData(text: 'Käse', mhd: '05.11.2020', quantity: 2),
    ProductData(text: 'Butter', mhd: '10.11.2020', quantity: 3),
  ];
  

   // Adds [item] to list
  void addItem(ProductData item) {
    items.add(item);
    notifyListeners();
  }

  // quantity of a single product +1
  void plus(ProductData item) {
    item.quantity++;
    notifyListeners();
  }

  // remove item from list
  void deleteItem(item) {
    items.remove(item);
    notifyListeners();

  }

  // quantity of a single product -1
   void minus(ProductData item) {
    item.quantity--;
    notifyListeners();
  }

  // change expiry date
  void changeDate(ProductData item, newDate) {
    item.mhd = newDate.toString();
    notifyListeners();
  }

  // set a username in settings
  void setName(text) {
    this.username = text;
    var prefs = SharedPreferences.getInstance();
    // save username 
              prefs.then((p) {
                p.setString("username", text);
              });
    
    notifyListeners();
  }

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
  notifyListeners();
}

}