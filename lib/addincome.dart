import 'package:flutter/material.dart';
import 'package:money/sqlite.dart';

class add_income_category extends StatefulWidget {
  @override
  _add_income_categoryState createState() => _add_income_categoryState();
}

class _add_income_categoryState extends State<add_income_category> {
  String category_name = '';
  String category_icon = '';
  int users_id = 0;
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolkey,
        appBar: AppBar(
          title: Text("Add Income Category".toUpperCase()),
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
              Container(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.keyboard),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Enter Income Catagory Name',
                  labelText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    category_name = value;
                  });
                },
              ),
              Container(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.keyboard),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Enter Your category icon',
                  labelText: 'Category Icon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    category_icon = value;
                  });
                },
              ),
              Container(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.red,
                  textColor: Colors.white,
                  icon: Icon(Icons.add_circle_outline),
                  label: Text("Add New Income Category".toUpperCase()),
                  onPressed: _addincomecategory,
                ),
              )
            ])));
  }

  _addincomecategory() async {
    if (category_name == "") {
      _scaffolkey.currentState
          .showSnackBar(SQLite.errorToast("please enter a income category"));
    } else {
      try {
        int userID = await SQLite().getUserId();
        var id = await SQLite().addincomecategory({
          'category_name': category_name.toString(),
          'category_icon': category_icon.toString(),
          // 'users_id': userID
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
