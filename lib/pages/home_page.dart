import 'package:flutter/material.dart';
import 'package:logbook/pages/add_page.dart';
import 'package:logbook/pages/list_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<HomePage> {

  int _selectedIndex = 0;

void updateNav(int index){
  setState(() {
    _selectedIndex = index;
  
  });

}

final List _pages = [
  AddPage(),
  listPage(),
];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dataset),
            label: 'Log List',
          ),
        ],
      ),
    );
  }
}