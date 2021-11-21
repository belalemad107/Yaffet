import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import'package:flutter/material.dart';
import 'package:yaffet/my%20depot/homae-layoutt.dart';
import 'package:yaffet/views/general_chart.dart';

import 'package:yaffet/views/price_alert.dart';
import 'package:yaffet/views/settings.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget>screens = [
    GeneralChartScreen(),
    PriceAlert(),
    BottomNavigation(),
    Settings(),
  ];
  int currentIndex = 0;
  @override
  void initState() {

    super.initState();
    Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.bar_chart,),label: 'Chart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Price Alert'),

          BottomNavigationBarItem(icon: Icon(Icons.beenhere),label: 'My Depot'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
