import 'package:flutter/material.dart';
import 'package:FridgerApp/inventory/productList.dart';
import 'package:FridgerApp/konto/konto.dart';
import 'package:FridgerApp/qrScanner/qrScanner.dart';

class Navbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // indexed list of pages (do NOT change number or order)
    InventoryList(),
    QRScanner(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Scan'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              title: Text('Konto'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
