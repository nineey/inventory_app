import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FridgerApp/helpers/changeNotifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // consumer
    final fridge = Provider.of<Fridge>(context); 

    // function to delete shared prefs (reset)
    Future<void> resetData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Konto von ' + fridge.username),
      ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.fromLTRB (0.0, 20.0, 0.0, 0.0),
              child: Text("Username anpassen", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
            // textfield to edit username
            // if no username is set: username = {Dein Name}
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fridge.username,
              ),
              onChanged: (text) {
                setState(() {
                  fridge.setName(text);
                });
              },
            ),
          ),
          
          // actually, username already saved after input. 
          // but added a saving button for better UX
          FlatButton(
            onPressed: () => fridge.setName(fridge.username),
            child: Text("Speichern"),
          ),


          SizedBox(height: 30.0),
          // section to change color of UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("App-Farbe ändern", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                color: Colors.blue,
                onPressed: () {
                  fridge.changeColor("blue");
                },
                child: Text("Blau", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 20.0,),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  fridge.changeColor("green");
                },
                child: Text("Grün", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 20.0,),
              FlatButton(
                color: Colors.grey,
                onPressed: () {
                  fridge.changeColor("grey");
                },
                child: Text("Grau", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),

SizedBox(height: 200.0),
          // reset shared prefs
          FlatButton(
            
            onPressed: () {
              resetData();
            },
            child: Text("Einstellungen zurücksetzen", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
