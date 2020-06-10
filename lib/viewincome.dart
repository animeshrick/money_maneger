import 'package:flutter/material.dart';
import 'package:money/sqlite.dart';

class ViewIncome extends StatefulWidget {
  @override
  _ViewIncomeState createState() => _ViewIncomeState();
}

class _ViewIncomeState extends State<ViewIncome> {
  List account_log = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getIncome();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: account_log.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(account_log[index]['category_name'].toString()),
              subtitle: Text(account_log[index]['create_date'].toString()),
              trailing: Text("Rs." + account_log[index]['ammount'].toString()),
            ),
          );
        });
  }

  _getIncome() async {
    final result = await SQLite().getaccount_log('credit');

    for (var i = 0; i < result.length; i++) {
      account_log.add({
        'create_date': result[i]['create_date'],
        'ammount': result[i]['ammount'],
        'category_name': await SQLite().getcategory_nameId(
            result[i]['income_category_id'], 'income_categary')
      });
    }
    setState(() {});
  }
}
