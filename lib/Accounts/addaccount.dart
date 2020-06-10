import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sqlite.dart';

class Addaccount extends StatefulWidget {
  @override
  _AddaccountState createState() => _AddaccountState();
}

class _AddaccountState extends State<Addaccount> {
  String account_name = '';
  String account_balence = '';
  int users_id = 0;
  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //users_id =SQLite().getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolkey,
      appBar: AppBar(
        title: Text("Add New Account".toUpperCase()),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.keyboard),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Enter Your Account Name',
                  labelText: 'Account Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    account_name = value;
                  });
                },
              ),
              Container(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  alignLabelWithHint: false,
                  hintStyle: TextStyle(fontSize: 14.0),
                  labelStyle: TextStyle(fontSize: 16.0),
                  hintText: 'Enter Your account blance',
                  labelText: 'Account Balence',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    account_balence = value;
                  });
                },
              ),
              Container(height: 10.0),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton.icon(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    icon: Icon(Icons.add_circle_outline),
                    label: Text("Add New Account".toUpperCase()),
                    onPressed: _addNewAccount,
                  ))
            ],
          )),
    );
  }

  _addNewAccount() async {
    if (account_name == "") {
      _scaffolkey.currentState
          .showSnackBar(SQLite.errorToast("please enter your account name"));
    } else if (account_balence == "") {
      _scaffolkey.currentState
          .showSnackBar(SQLite.errorToast("please enter starting balance"));
    } else {
      try {
        int userID = await SQLite().getUserId();
        var id = await SQLite().addNewAccount({
          'account_name': account_name.toString(),
          'account_balance': (account_balence.toString()),
          'users_id': userID
        });
        Navigator.pop(context);
      } catch (e) {
        print(e);
      }
    }
  }
}
