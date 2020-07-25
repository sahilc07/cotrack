import 'package:flutter/material.dart';
import 'Screens/homepage.dart';
import 'Screens/helplinepage.dart';
import 'Screens/newspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CoTrack',
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: BaseApp(),
    );
  }
}

class BaseApp extends StatefulWidget {
  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomePage(),
    HelplinePage(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('CoTrack'),
      // ),
      body: Center(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            title: Text('Helpline'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            title: Text('News'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.lightBlueAccent,
      ),
    );
  }
}
