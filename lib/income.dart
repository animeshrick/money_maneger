import 'package:flutter/material.dart';
import 'package:money/addincome.dart';
import 'package:money/sqlite.dart';

class incomecategory extends StatefulWidget {
  @override
  _incomecategoryState createState() => _incomecategoryState();
}

class _incomecategoryState extends State<incomecategory> {
  List income_categary = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getincome_categaryList();
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
                      builder: (context) => add_income_category());
                  var returnBack = await Navigator.push(context, route);
                  await getincome_categaryList();
                })
          ]),
      body: ListView.builder(
          itemCount: income_categary.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(income_categary[index]['category_name'].toString()),
              ),
            );
          }),
    );
  }

  getincome_categaryList() async {
    final result = await SQLite().getincome_categaryList();
    print(result);
    setState(() {
      income_categary = result;
    });
  }
}
