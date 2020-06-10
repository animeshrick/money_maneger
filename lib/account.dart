import 'package:flutter/material.dart';
import 'package:money/sqlite.dart';

import 'Accounts/addaccount.dart';

class accounts extends StatefulWidget {
  @override
  _accountsState createState() => _accountsState();
}

class _accountsState extends State<accounts> {
  List account = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('accounts'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              Route route =
                  MaterialPageRoute(builder: (context) => Addaccount());
              var returnBack = await Navigator.push(context, route);
              await getAccountList();
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: account.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(account[index]['account_name'].toString()),
                trailing:
                    Text("Rs." + account[index]['account_balance'].toString()),
              ),
            );
          }),
    );
  }

  getAccountList() async {
    final result = await SQLite().getAccountList();
    print(result);
    setState(() {
      account = result;
    });
  }
}
