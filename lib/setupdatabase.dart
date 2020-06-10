import 'package:flutter/material.dart';
import 'package:money/sqlite.dart';

import 'homea.dart';
import 'login.dart';

class Setup_database extends StatefulWidget {
  @override
  _Setup_databaseState createState() => _Setup_databaseState();
}

class _Setup_databaseState extends State<Setup_database> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  initDatabase() async {
    var datebase = SQLite();
    await datebase.setup();
    bool is_login = await SQLite().is_login();
    print(is_login);
    if (is_login) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }
}
