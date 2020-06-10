import 'package:flutter/material.dart';
import 'package:money/homea.dart';
import 'package:money/sqlite.dart';

import 'sqlite.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mobile = "";
  String password = "";

  final GlobalKey<ScaffoldState> _scaffolkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffolkey,
        backgroundColor: Colors.pinkAccent,
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15.0, 30.0, .0, .0),
            child: Text('MONEY APP',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(15, 11, 0.0, 0.0),
              child: Text(
                'The Easiest way',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(55, 20, 20, 0),
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'mobile',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  onChanged: (value) {
                    setState(() {
                      mobile = value;
                    });
                  },
                ),
                SizedBox(height: 30.0),
                TextField(
                  decoration: InputDecoration(
                      labelText: 'password',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                Center(
                    child: RaisedButton(
                        color: Colors.orange,
                        child: Text(
                          "login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _loginCheck))
              ])),
        ])));
  }

  _loginCheck() async {
    if (mobile == "") {
      _scaffolkey.currentState
          .showSnackBar(SQLite.errorToast("please enter your mobile number"));
    } else if (password == "") {
      _scaffolkey.currentState
          .showSnackBar(SQLite.errorToast("please enter your password"));
    } else {
      final result = await SQLite().login(mobile, password);
      if (result.length > 0) {
        var user_id = result[0]['id'];
        print(user_id);

        await SQLite().storelogininfo(mobile, password, user_id);
        Route route = MaterialPageRoute(builder: (context) => Homepage());
        Navigator.pushReplacement(context, route);
      } else {
        _scaffolkey.currentState
            .showSnackBar(SQLite.errorToast("no user found"));
      }
    }
  }
}
