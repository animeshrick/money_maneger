import 'package:flutter/material.dart';
import 'income.dart';
import 'expenses.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => incomecategory()),
                );
              },
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    'Manage Income Category',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => expensescategory()),
                );
              },
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  child: Text(
                    'Manage Expence Category',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Container(height: 30,),
            IconButton(
                icon: Icon(Icons.local_activity,
                  color: Colors.red ,),
                onPressed: (){}),
          ]
      ),

    );


  }
}