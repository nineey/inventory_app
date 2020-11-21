import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FridgerApp/helpers/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final fridge = Provider.of<Fridge>(context); // consumer

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
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fridge.username,
              ),
              onChanged: (text) {
                setState(() {
                  fridge.username = text;
                });
                fridge.username = text;
              },
            ),
          ),
          //
          //FlatButton(
           // onPressed: () => fridge.setName(fridge.username),
           // child: Text("Rename"),
         // ),


          SizedBox(height: 30.0),
          // section to change color of UI
          Text("App-Farbe ändern", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
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

SizedBox(height: 100.0),
          // reset shared prefs
          FlatButton(
            
            onPressed: () {
              resetData();
            },
            child: Text("Reset shared prefs", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
