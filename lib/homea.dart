import 'package:flutter/material.dart';
import 'package:money/account.dart';

import 'money.dart';
import 'settings.dart';
import 'trans.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  TabController _myTabController;

  List<Widget> _widgetOptions = [
    Trans(),
    money(),
    accounts(),
    settings(),
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    print(_selectedIndex);
    _myTabController = TabController(vsync: this, length: 4);
  }

  var Myso = "date";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('Trans'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('stats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            title: Text('account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.redAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget Mydate(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          getDate(context);
        },
        child: Text(Myso),
      ),
    );
  }

  getDate(BuildContext context) async {
    Future<DateTime> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    setState(() {
      Myso = selectedDate.toString();
    });
  }
}
