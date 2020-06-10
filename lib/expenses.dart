import 'package:flutter/material.dart';
import 'package:money/addexpenses.dart';
import 'package:money/sqlite.dart';

class expensescategory extends StatefulWidget {
  @override
  _expensescategoryState createState() => _expensescategoryState();
}

class _expensescategoryState extends State<expensescategory> {
  List expense_category = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getexpense_categoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Added Income Category'),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.edit, color: Colors.white), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () async {
                  Route route = MaterialPageRoute(
                      builder: (context) => add_expenses_category());
                  var returnBack = await Navigator.push(context, route);
                  await getexpense_categoryList();
                })
          ]),
      body: ListView.builder(
          itemCount: expense_category.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title:
                    Text(expense_category[index]['category_name'].toString()),
              ),
            );
          }),
    );
  }

  getexpense_categoryList() async {
    final result = await SQLite().getexpense_categoryList();
    print(result);
    setState(() {
      expense_category = result;
    });
  }
}
